import psycopg2
import os
import re
from datetime import datetime
from reportlab.lib.pagesizes import letter, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
import chardet

def mostrar_menu():
    print("\nMenu de Opciones:")
    print("1. Generacion de Disparadores de Auditoria")
    print("2. Logs")
    print("3. Salir")

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    
    cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
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
                funcion_sql = crear_funcion_trigger(tabla)
                trigger_sql = crear_trigger(tabla)
                sql_file.write(funcion_sql)
                sql_file.write(trigger_sql)
                cursor.execute(funcion_sql)
                cursor.execute(trigger_sql)
                
    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")

def crear_funcion_trigger(tabla):
    return f"""
    CREATE OR REPLACE FUNCTION audit_{tabla}() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('{tabla}', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('{tabla}', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('{tabla}', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    """

def crear_trigger(tabla):
    trigger_name = f"{tabla}_audit_trigger"
    return f"""
    DROP TRIGGER IF EXISTS {trigger_name} ON {tabla};
    CREATE TRIGGER {trigger_name}
    AFTER INSERT OR UPDATE OR DELETE ON {tabla}
    FOR EACH ROW EXECUTE FUNCTION audit_{tabla}();
    """

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

    title = "Reporte de Logs"
    elements.append(Paragraph(title, styles['Title']))
    elements.append(Spacer(1, 12))

    col_widths = [100, 60, 60, 80, 60, 60, 240, 60]
    data = [["Fecha y Hora", "ID del Proceso", "Usuario", "Base de Datos", "Aplicación", "Nivel del Log", "Mensaje", "Operación"]]
    
    for log in logs:
        fecha_hora = log['fecha_hora'].split(" ")
        fecha = fecha_hora[0]
        hora = fecha_hora[1]
        fecha_hora_formateada = Paragraph(f"{fecha}<br/>{hora}", date_time_style)
        row = [
            fecha_hora_formateada,
            log['id_proceso'],
            log['usuario'],
            log['base_datos'],
            log['aplicacion'],
            log['nivel'],
            Paragraph(log['mensaje'], custom_style),
            log['operacion']
        ]
        data.append(row)

    table = Table(data, colWidths=col_widths)
    table.setStyle(TableStyle([
        ('BACKGROUND', (0, 0), (-1, 0), colors.grey),
        ('TEXTCOLOR', (0, 0), (-1, 0), colors.whitesmoke),
        ('ALIGN', (0, 0), (-1, -1), 'LEFT'),
        ('FONTNAME', (0, 0), (-1, 0), 'Helvetica-Bold'),
        ('FONTSIZE', (0, 0), (-1, 0), 8),
        ('BOTTOMPADDING', (0, 0), (-1, 0), 8),
        ('BACKGROUND', (0, 1), (-1, -1), colors.beige),
        ('GRID', (0, 0), (-1, -1), 1, colors.black),
        ('VALIGN', (0, 0), (-1, -1), 'TOP'),
        ('LEFTPADDING', (0, 0), (-1, -1), 4),
        ('RIGHTPADDING', (0, 0), (-1, -1), 4),
    ]))
    elements.append(table)

    doc.build(elements)
    print(f"Reporte PDF generado: {pdf_filename}")


def obtener_usuarios(cursor):
    cursor.execute("SELECT usename FROM pg_user;")
    return [usuario[0] for usuario in cursor.fetchall()]

def categorizar_operacion(mensaje):
    if re.search(r'\bINSERT\b', mensaje, re.IGNORECASE):
        return 'CREATE'
    elif re.search(r'\bSELECT\b', mensaje, re.IGNORECASE):
        return 'READ'
    elif re.search(r'\bUPDATE\b', mensaje, re.IGNORECASE):
        return 'UPDATE'
    elif re.search(r'\bDELETE\b', mensaje, re.IGNORECASE):
        return 'DELETE'
    elif re.search(r'\bCALL\b', mensaje, re.IGNORECASE):
        return 'CALL'
    elif re.search(r'\bDROP\b', mensaje, re.IGNORECASE):
        return 'DROP'
    else:
        return 'OTHER'

def leer_logs_en_rango(log_directory, fecha_inicio, fecha_fin, usuario):
    logs_combinados = []
    try:
        fecha_inicio = datetime.strptime(fecha_inicio, "%Y-%m-%d %H:%M:%S")
        fecha_fin = datetime.strptime(fecha_fin, "%Y-%m-%d %H:%M:%S")
    except ValueError:
        print("Formato de fecha y hora incorrecto.")
        return []

    log_files = sorted(os.listdir(log_directory))
    for log_file in log_files:
        log_path = os.path.join(log_directory, log_file)
        if os.path.getsize(log_path) > 0:
            with open(log_path, 'rb') as file:
                raw_data = file.read()
                result = chardet.detect(raw_data)
                encoding = result['encoding']
                decoded_data = raw_data.decode(encoding)
                for line in decoded_data.splitlines():
                    match = re.match(r"(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) -(\d{2}) \[(\d+)\]: \[(\d+-\d+)\] user=(\w+),db=(\w+),app=\[(.*?)\] (\w+): (.+)", line)
                    if match:
                        log_fecha = datetime.strptime(match.group(1), "%Y-%m-%d %H:%M:%S")
                        if fecha_inicio <= log_fecha <= fecha_fin and match.group(5) == usuario:
                            mensaje = match.group(9)
                            operacion = categorizar_operacion(mensaje)
                            log_entry = {
                                'fecha_hora': match.group(1),
                                'id_proceso': match.group(3),
                                'usuario': match.group(5),
                                'base_datos': match.group(6),
                                'aplicacion': match.group(7),
                                'nivel': match.group(8),
                                'mensaje': mensaje,
                                'operacion': operacion
                            }
                            logs_combinados.append(log_entry)
    return logs_combinados

def opcion2(cursor):
    print("Ejecutando Opción 2...")

    usuarios = obtener_usuarios(cursor)
    print("\nUsuarios disponibles:")
    for idx, usuario in enumerate(usuarios):
        print(f"{idx + 1}. {usuario}")

    seleccion_usuario = input("\nSeleccione un usuario (número): ")
    try:
        usuario = usuarios[int(seleccion_usuario) - 1]
    except (IndexError, ValueError):
        print("Selección de usuario inválida.")
        return

    while True:
        fecha_inicio = input("Ingrese la fecha y hora de inicio (YYYY-MM-DD HH:MM:SS): ")
        fecha_fin = input("Ingrese la fecha y hora de fin (YYYY-MM-DD HH:MM:SS): ")
        if validar_fechas(fecha_inicio, fecha_fin):
            break

    log_directory = r"C:\\Program Files\\PostgreSQL\\14\\data\\log"
    logs = leer_logs_en_rango(log_directory, fecha_inicio, fecha_fin, usuario)
    
    if not logs:
        print("No se encontraron registros para los criterios especificados.")
    else:
        print("\nContenido de los logs seleccionados:\n")
        for log in logs:
            print(f"{log['fecha_hora']} - {log['id_proceso']} - {log['usuario']} - {log['base_datos']} - {log['aplicacion']} - {log['nivel']} - {log['mensaje']} - {log['operacion']}")

        pdf_filename = input("Ingrese el nombre del archivo PDF a generar: ") + ".pdf"
        generar_pdf(logs, pdf_filename)


def validar_fechas(fecha_inicio, fecha_fin):
    try:
        datetime.strptime(fecha_inicio, "%Y-%m-%d %H:%M:%S")
        datetime.strptime(fecha_fin, "%Y-%m-%d %H:%M:%S")
        return True
    except ValueError:
        print("Formato de fecha y hora incorrecto. Por favor, intente nuevamente.")
        return False

def main():
    database = "restaurante"
    try:
        conexion = psycopg2.connect(
            host="localhost",
            database=database,
            user="postgres",
            password="adm"
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
    except psycopg2.Error as e:
        print(f"Error en la conexión a la base de datos: {e}")
    finally:
        if 'cursor' in locals() and not cursor.closed:
            cursor.close()
        if 'conexion' in locals() and not conexion.closed:
            conexion.close()

if __name__ == '__main__':
    main()
