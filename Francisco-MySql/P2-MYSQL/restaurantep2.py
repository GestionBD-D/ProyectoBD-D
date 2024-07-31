import mysql.connector
import threading
from datetime import datetime
from reportlab.platypus import SimpleDocTemplate, Spacer, Table, TableStyle
from time import time
from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import inch

def mostrar_menu():
    print("\nMenu de Opciones:")
    print("1. Generacion de Disparadores de Auditoria")
    print("2. Hilos")
    print("3. Salir")   

def obtener_columnas_tabla(cursor, tabla):
    cursor.execute(f"SHOW COLUMNS FROM {tabla}")
    columnas = cursor.fetchall()
    nombres_columnas = [columna[0] for columna in columnas]
    return nombres_columnas

def crear_funcion_trigger(cursor, tabla):
    columnas = obtener_columnas_tabla(cursor, tabla)

    insert_values = ", ".join([f"'new_{columna.lower()}', NEW.{columna}" for columna in columnas])
    update_values = ", ".join([f"'old_{columna.lower()}', OLD.{columna}, 'new_{columna.lower()}', NEW.{columna}" for columna in columnas])
    delete_values = ", ".join([f"'old_{columna.lower()}', OLD.{columna}" for columna in columnas])

    funcion_insert_sql = f"""
    CREATE OR REPLACE TRIGGER audit_{tabla}_after_insert
    AFTER INSERT ON {tabla}
    FOR EACH ROW 
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('{tabla}', USER(), 'INSERT', JSON_OBJECT({insert_values}));
    END;
    """

    funcion_update_sql = f"""
    CREATE OR REPLACE TRIGGER audit_{tabla}_after_update
    AFTER UPDATE ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('{tabla}', USER(), 'UPDATE', JSON_OBJECT({update_values}));
    END;
    """

    funcion_delete_sql = f"""
    CREATE OR REPLACE TRIGGER audit_{tabla}_after_delete
    AFTER DELETE ON {tabla}
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('{tabla}', USER(), 'DELETE', JSON_OBJECT({delete_values}));
    END;
    """

    try:
        cursor.execute(funcion_insert_sql)
    except mysql.connector.Error as err:
        print(f"Error al ejecutar el disparador INSERT para {tabla}: {err}")

    try:
        cursor.execute(funcion_update_sql)
    except mysql.connector.Error as err:
        print(f"Error al ejecutar el disparador UPDATE para {tabla}: {err}")

    try:
        cursor.execute(funcion_delete_sql)
    except mysql.connector.Error as err:
        print(f"Error al ejecutar el disparador DELETE para {tabla}: {err}")

    return funcion_insert_sql, funcion_update_sql, funcion_delete_sql


def opcion1(cursor):
    print("Ejecutando Opción 1...")
    
    cursor.execute("SHOW TABLES")
    tablas = cursor.fetchall()
    
    print("\nTablas disponibles en la base de datos:")
    for idx, tabla in enumerate(tablas):
        print(f"{idx + 1}. {tabla[0]}")
    
    seleccion = input("\nSeleccione las tablas para auditar (separadas por coma, o 'all' para todas): ")
    
    if seleccion.lower() == 'all':
        tablas_seleccionadas = [tabla[0] for tabla in tablas]
    else:
        try:
            indices = map(int, seleccion.split(','))
            tablas_seleccionadas = [tablas[idx - 1][0] for idx in indices]
        except ValueError:
            print("Selección inválida. Por favor, use números separados por comas.")
            return

    with open("auditoria_triggers.sql", "w", encoding="utf-8") as sql_file:
        for tabla in tablas_seleccionadas:
            if tabla.lower() != 'auditoria':
                funciones_sql = crear_funcion_trigger(cursor, tabla)
                for funcion_sql in funciones_sql:
                    sql_file.write(funcion_sql)
                    sql_file.write("\n\n")  # Separador entre funciones

    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")


def generar_pdf(logs, pdf_filename):
    doc = SimpleDocTemplate(pdf_filename, pagesize=landscape(letter))
    styles = getSampleStyleSheet()
    custom_style = ParagraphStyle(
        name='CustomStyle',
        fontSize=9,
        leading=10,
        spaceAfter=4,
        wordWrap='CJK'
    )
    date_time_style = ParagraphStyle(
        name='DateTimeStyle',
        fontSize=9,
        leading=10,
        spaceAfter=4,
        wordWrap='CJK',
        alignment=1
    )
    elements = []

def ejecutar_consulta(cursor, lock, query, results, index):
    try:
        start_time = time()
        with lock:
            cursor.execute(query)
            result = cursor.fetchall()
            headers = [desc[0] for desc in cursor.description]
        end_time = time()
        execution_time = end_time - start_time
        results[index] = (headers, result, execution_time)
    except Exception as e:
        results[index] = ([], str(e), 0)

def opcion2(cursor):
    print("Ejecutando Opción 2...")

    # Consultas complejas
    queries = [
        "SELECT ORDEN.ID_ORDEN, ORDEN.FECHA_ORDEN, CLIENTE.NOMBRE, CLIENTE.APELLIDO, ORDEN.TOTAL_PAGAR FROM ORDEN INNER JOIN CLIENTE ON ORDEN.CLIENTE_ID_CLIENTE = CLIENTE.ID_CLIENTE",
        "SELECT RESERVACION.ID_RESERVACION, RESERVACION.FECHA_RESERVACION, CLIENTE.NOMBRE, CLIENTE.APELLIDO, MESA.CAPACIDAD, MESA.DISPONIBILIDAD FROM RESERVACION INNER JOIN CLIENTE ON RESERVACION.CLIENTE_ID_CLIENTE = CLIENTE.ID_CLIENTE INNER JOIN MESA ON RESERVACION.MESA_ID_MESA = MESA.ID_MESA",
        "SELECT CLIENTE.NOMBRE, CLIENTE.APELLIDO, QUEJA.FECHA_QUEJA, CLIENTE_QUEJA.DSCR_QUEJA FROM CLIENTE_QUEJA INNER JOIN CLIENTE ON CLIENTE_QUEJA.CLIENTE_ID_CLIENTE = CLIENTE.ID_CLIENTE INNER JOIN QUEJA ON CLIENTE_QUEJA.QUEJA_ID_QUEJA = QUEJA.ID_QUEJA",
        "SELECT PLATO.NOMBRE_PLATO, INGREDIENTES.NOM_INGREDIENTE, PLATO_INGREDIENTES.CANTIDAD FROM PLATO_INGREDIENTES INNER JOIN PLATO ON PLATO_INGREDIENTES.PLATO_ID_PLATO = PLATO.ID_PLATO INNER JOIN INGREDIENTES ON PLATO_INGREDIENTES.INGREDIENTES_ID_INGREDIENTES = INGREDIENTES.ID_INGREDIENTES",
    ]

    threads = []
    results = [None] * len(queries)
    lock = threading.Lock()

    for i, query in enumerate(queries):
        thread = threading.Thread(target=ejecutar_consulta, args=(cursor, lock, query, results, i))
        threads.append(thread)
        thread.start()

    for thread in threads:
        thread.join()

    generar_pdf_con_resultados(queries, results)

def generar_pdf_con_resultados(queries, results):
    fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = f"Resultados_Consultas_{fecha_hora}.pdf"

    doc = SimpleDocTemplate(output_path, pagesize=letter)
    story = []

    for i, (query, (headers, result, exec_time)) in enumerate(zip(queries, results)):
        story.append(Table([[f"Consulta {i + 1}", query]], colWidths=[2.5 * inch, 4.5 * inch]))
        story.append(Table([["Tiempo de ejecución:", f"{exec_time} segundos"]], colWidths=[2.5 * inch, 4.5 * inch]))
        story.append(Table([["Resultados:"]], colWidths=[7 * inch]))
        
        if isinstance(result, list) and result:
            data = [headers] + result
        else:
            data = [["Sin resultados"]]
        
        t = Table(data)
        t.setStyle(TableStyle([
            ('BACKGROUND', (0, 0), (-1, 0), colors.gray),
            ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
            ('ALIGN', (0, 0), (-1, -1), 'CENTER'),
            ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
            ('BOTTOMPADDING', (0, 0), (-1, 0), 12),
            ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
            ('GRID', (0, 0), (-1, -1), 1, colors.black),
            ('BOX', (0, 0), (-1, -1), 2, colors.black),
        ]))
        
        story.append(t)
        story.append(Spacer(1, 12))

    doc.build(story)
    print(f"Informe generado en: {output_path}")

def main():
    database = "restaurante2"
    try:
        conexion = mysql.connector.connect(
            host="localhost",
            port=3306,
            database=database,
            user="root",
            password="Francisco2002"
        )
        conexion.autocommit = True
        cursor = conexion.cursor()
        
        while True:
            mostrar_menu()
            opcion = input("Selecciona una opción: ")
            if opcion == '1':
                opcion1(cursor)
            elif opcion == '2':
                opcion2(cursor)
            elif opcion == '3':
                print("Saliendo del programa...")
                break
            else:
                print("Opción no válida. Por favor, intenta de nuevo.")
    except mysql.connector.Error as e:
        print(f"Error en la conexión a la base de datos: {e}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conexion' in locals() and conexion.is_connected():
            conexion.close()

if __name__ == '__main__':
    main()
