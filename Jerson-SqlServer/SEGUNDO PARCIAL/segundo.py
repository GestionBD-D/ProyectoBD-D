import pyodbc
import threading
from time import time
from datetime import datetime
from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Spacer, Table, TableStyle
from reportlab.lib.units import inch

def mostrar_menu():
    print("\nMenu de Opciones:")
    print("1. Triggers")
    print("2. Aplicación de Hilos")
    print("3. Salir")

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    
    cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'dbo'")
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
                drop_trigger_sql, create_trigger_sql = crear_trigger(tabla)
                sql_file.write(drop_trigger_sql + "\n" + create_trigger_sql + "\n")
                cursor.execute(drop_trigger_sql)
                cursor.execute(create_trigger_sql)
                
    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")

def crear_trigger(tabla):
    trigger_name = f"{tabla}_audit_trigger"
    drop_trigger_sql = f"""
    IF OBJECT_ID('{trigger_name}', 'TR') IS NOT NULL
    DROP TRIGGER {trigger_name};
    """
    create_trigger_sql = f"""
    CREATE TRIGGER {trigger_name}
    ON {tabla}
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT '{tabla}', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT '{tabla}', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT '{tabla}', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    """
    return drop_trigger_sql, create_trigger_sql

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
    database = "restaurante"
    try:
        conexion = pyodbc.connect(
            "DRIVER={SQL Server Native Client 11.0};"
            "SERVER=CUENCA;"
            "DATABASE=" + database + ";"
            "UID=sa;"
            "PWD=Jerson0802;"
            "Trusted_Connection=yes"
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
    except pyodbc.Error as e:
        print(f"Error en la conexión a la base de datos: {e}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conexion' in locals():
            conexion.close()

if __name__ == '__main__':
    main()
