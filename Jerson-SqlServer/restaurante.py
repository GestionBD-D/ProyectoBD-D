import pyodbc
import subprocess
import os
from datetime import datetime
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
from reportlab.lib import colors
import shutil
import time


def mostrar_menu():
    print("\nMenu de Opciones:")
    print("1. Crear usuario en la base de datos")
    print("2. Lista de usuarios en la base de datos")
    print("3. Modificar un usuario")
    print("4. Eliminar un usuario")
    print("5. Crear un rol")
    print("6. Lista de Roles")
    print("7. Asignar un rol a un usuario")
    print("8. Respaldar base de datos")
    print("9. Restaurar base de datos")
    print("10. Generar PDF")
    print("11. CRUD")
    print("12. Salir")

    # CREAR USUARIOS A NIVEL DE SERVIDOR
def crear_usuario_servidor(cursor, nombre_usuario, contraseña):
    try:
        query_login = f"CREATE LOGIN {nombre_usuario} WITH PASSWORD = '{contraseña}'"
        cursor.execute(query_login)
        print("Usuario creado exitosamente a nivel de servidor.")
    except Exception as e:
        print(f"Error al crear el usuario a nivel de servidor: {e}")

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    nombre_usuario = input("Ingrese el nombre del nuevo usuario del servidor: ")
    contraseña = input("Ingrese la contraseña para el nuevo usuario: ")
    crear_usuario_servidor(cursor, nombre_usuario, contraseña)

# MOSTRAR USUARIOS A NIVEL DE SERVIDOR
def mostrar_usuarios_servidor(cursor):
    try:
        query = """
        SELECT name 
        FROM sys.server_principals 
        WHERE type IN ('S', 'U')
        AND name NOT IN (
            'NT AUTHORITY\\SYSTEM', 
            'NT Service\\MSSQLSERVER', 
            'NT SERVICE\\SQLSERVERAGENT', 
            'NT SERVICE\\SQLTELEMETRY', 
            'NT SERVICE\\SQLWriter', 
            'NT SERVICE\\Winmgmt', 
            '##MS_PolicyEventProcessingLogin##', 
            '##MS_PolicyTsqlExecutionLogin##'
        )
        ORDER BY name;
        """
        cursor.execute(query)
        usuarios = cursor.fetchall()
        if usuarios:
            print("Usuarios en el servidor:")
            for index, usuario in enumerate(usuarios, start=1):
                print(f"{index}. {usuario[0]}")
            return usuarios
        else:
            print("No hay usuarios disponibles en el servidor.")
            return []
    except Exception as e:
        print(f"Error al obtener la lista de usuarios en el servidor: {e}")
        return []

def opcion2(cursor):
    print("Ejecutando Opción 2...")
    mostrar_usuarios_servidor(cursor)

    #MODIFICAR USUARIOS
def cambiar_nombre_usuario(cursor, nombre_actual, nuevo_nombre):
    try:
        query = f"ALTER LOGIN [{nombre_actual}] WITH NAME = [{nuevo_nombre}]"
        cursor.execute(query)
        print("Nombre de usuario cambiado exitosamente.")
    except Exception as e:
        print(f"Error al cambiar el nombre del usuario: {e}")


def cambiar_contraseña_usuario(cursor, nombre_usuario, nueva_contraseña):
    try:
        query = f"ALTER LOGIN [{nombre_usuario}] WITH PASSWORD = '{nueva_contraseña}'"
        cursor.execute(query)
        print("Contraseña cambiada exitosamente.")
    except Exception as e:
        print(f"Error al cambiar la contraseña del usuario: {e}")

def opcion3(cursor):
    print("Ejecutando Opción 3...")
    usuarios = mostrar_usuarios_servidor(cursor)
    if usuarios:
        try:
            eleccion = int(input("Seleccione el número del usuario a modificar: "))
            nombre_actual = usuarios[eleccion - 1][0] 
            nuevo_nombre = input("Ingrese el nuevo nombre del usuario: ")
            nueva_contraseña = input("Ingrese la nueva contraseña del usuario: ")
            
            cambiar_nombre_usuario(cursor, nombre_actual, nuevo_nombre)
            cambiar_contraseña_usuario(cursor, nuevo_nombre, nueva_contraseña)  
        except ValueError:
            print("Por favor, ingrese un número válido.")
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
    else:
        print("No hay usuarios para modificar.")

    # ELIMINAR USUARIOS A NIVEL DE SERVIDOR
def eliminar_usuario_servidor(cursor, nombre_usuario):
    try:
        query = f"DROP LOGIN {nombre_usuario}"
        cursor.execute(query) 
        print("Usuario eliminado exitosamente.")
    except Exception as e:
        print(f"Error al eliminar el usuario: {e}")

def opcion4(cursor):
    print("Ejecutando Opción 4...")
    usuarios = mostrar_usuarios_servidor(cursor)
    if usuarios:
        try:
            eleccion = int(input("Seleccione el número del usuario a eliminar: "))
            nombre_usuario = usuarios[eleccion - 1][0]  
            confirmacion = input(f"Está seguro de que desea eliminar al usuario '{nombre_usuario}'? (s/n): ")
            if confirmacion.lower() == 's':
                eliminar_usuario_servidor(cursor, nombre_usuario)
            else:
                print("Eliminación cancelada.")
        except ValueError:
            print("Por favor, ingrese un número válido.")
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
    else:
        print("No hay usuarios para eliminar.")

    # CREAR UN ROL A NIVEL DE SERVIDOR
def crear_rol_servidor(cursor, nombre_rol):
    try:
        query = f"CREATE SERVER ROLE {nombre_rol}"
        cursor.execute(query)
        print(f"Rol '{nombre_rol}' creado exitosamente a nivel de servidor.")
    except Exception as e:
        print(f"Error al crear el rol a nivel de servidor: {e}")

def opcion5(cursor):
    print("Ejecutando Opción 5...")
    nombre_rol = input("Ingrese el nombre del nuevo rol del servidor: ")
    crear_rol_servidor(cursor, nombre_rol)

    #MOSTRAR ROLES
def mostrar_roles_servidor(cursor):
    try:
        cursor.execute("""
        SELECT name FROM sys.server_principals 
        WHERE type = 'R'
        AND name NOT IN (
            'sysadmin', 
            'securityadmin', 
            'serveradmin', 
            'setupadmin', 
            'processadmin', 
            'diskadmin', 
            'dbcreator', 
            'bulkadmin'
        )
        ORDER BY name;
        """)
        roles = cursor.fetchall()
        if roles:
            print("Roles disponibles en el servidor:")
            for index, rol in enumerate(roles, start=1):
                print(f"{index}. {rol[0]}")
            return roles
        else:
            print("No hay roles disponibles en el servidor.")
            return []
    except Exception as e:
        print(f"Error al obtener la lista de roles en el servidor: {e}")
        return []

def opcion6(cursor):
    print("Ejecutando Opción 6...")
    mostrar_roles_servidor(cursor)

    # ASIGNAR UN ROL A UN USUARIO A NIVEL DE SERVIDOR
def asignar_rol_a_usuario_servidor(cursor, nombre_usuario, nombre_rol):
    try:
        query = f"ALTER SERVER ROLE {nombre_rol} ADD MEMBER {nombre_usuario}"
        cursor.execute(query)
        print(f"Rol '{nombre_rol}' asignado exitosamente a '{nombre_usuario}'.")
    except Exception as e:
        print(f"Error al asignar el rol: {e}")

def opcion7(cursor):
    print("Ejecutando Opción 7...")
    usuarios = mostrar_usuarios_servidor(cursor)
    if usuarios:
        try:
            seleccion_usuario = int(input("Seleccione el número del usuario al que asignar el rol: ")) - 1
            nombre_usuario = usuarios[seleccion_usuario][0]
        except ValueError:
            print("Por favor, ingrese un número válido.")
            return
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
            return

    roles = mostrar_roles_servidor(cursor)
    if roles:
        try:
            seleccion_rol = int(input("Seleccione el número del rol a asignar: ")) - 1
            nombre_rol = roles[seleccion_rol][0]
        except ValueError:
            print("Por favor, ingrese un número válido.")
            return
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
            return

    asignar_rol_a_usuario_servidor(cursor, nombre_usuario, nombre_rol)

    #RESPALDO DE BASE DE DATOS
def realizar_respaldo(server, database, user, password, output_dir):
    try:
        # Asegurarse de que el directorio de salida existe, si no, crearlo
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
            print(f"Directorio {output_dir} creado.")
        
        # Generar nombre de archivo basado en la fecha y hora actual
        fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
        nombre_archivo = f"{database}_{fecha_hora}.bak"  # Archivo .bak
        output_path = os.path.join(output_dir, nombre_archivo)

        # Utilizar una ruta en una ubicación accesible por SQL Server
        sql_output_path = f"C:\\SQLBackups\\{nombre_archivo}"
        if not os.path.exists("C:\\SQLBackups"):
            os.makedirs("C:\\SQLBackups")
        
        # Configurar la cadena de conexión
        connection_string = f"DRIVER={{SQL Server Native Client 11.0}};Server={server};Database={database};UID={user};PWD={password};Trusted_Connection=yes"
        
        # Conectar a la base de datos y ejecutar el respaldo
        with pyodbc.connect(connection_string, autocommit=True) as conn:
            with conn.cursor() as cursor:
                backup_query = f"BACKUP DATABASE [{database}] TO DISK = N'{sql_output_path}' WITH NOFORMAT, NOINIT, NAME = N'{database}-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10"
                cursor.execute(backup_query)
                print(f"Respaldo realizado exitosamente en {sql_output_path}")

        # Pausa breve para asegurar que SQL Server haya liberado el archivo
        time.sleep(5)

        # Verificar si el archivo de respaldo fue creado exitosamente
        if os.path.exists(sql_output_path):
            print(f"Archivo de respaldo creado exitosamente: {sql_output_path}")
            # Copiar el archivo a la ubicación final
            shutil.copy(sql_output_path, output_path)
            print(f"Archivo copiado a la ubicación final: {output_path}")
        else:
            print("Error: el archivo de respaldo no fue creado.")

    except pyodbc.Error as e:
        print(f"Error al realizar el respaldo: {e}")
    except Exception as e:
        print(f"Error inesperado: {e}")

def opcion8(cursor):
    print("Ejecutando Opción 8...")
    server = "CUENCA"
    database = "restaurante"
    user = "sa"
    password = "Jerson0802"
    output_dir = r"E:\JERSON\UNIVERSIDAD\6 S-NIVELACION\GESTION DE BASE DE DATOS-TUTORIAS\Proyecto\Proyecto 1P\respaldos"
    realizar_respaldo(server, database, user, password, output_dir)


    #RESTAURAR BASE DE DATOS
def listar_archivos_de_respaldo(directorio_respaldo):
    archivos = [f for f in os.listdir(directorio_respaldo) if f.endswith('.bak')]
    if archivos:
        print("Archivos de respaldo disponibles:")
        for idx, archivo in enumerate(archivos, start=1):
            print(f"{idx}. {archivo}")
    else:
        print("No hay archivos de respaldo disponibles.")
    return archivos

def realizar_restauracion(server, database, user, password, respaldo_path):
    try:
        # Obtener información sobre el archivo de respaldo
        move_data_path = f"C:\\SQLBackups\\{database}.mdf"
        move_log_path = f"C:\\SQLBackups\\{database}_log.ldf"

        # Intentar eliminar la base de datos si existe
        subprocess.run([
            "sqlcmd", "-S", server, "-U", user, "-P", password, "-Q", 
            f"IF EXISTS(SELECT name FROM sys.databases WHERE name = '{database}') DROP DATABASE {database};"
        ], check=True)
            
        # Restaurar el archivo de respaldo en la nueva base de datos con nuevas ubicaciones para los archivos .mdf y .ldf
        restore_command = f"""
        RESTORE DATABASE [{database}] 
        FROM DISK = N'{respaldo_path}' 
        WITH MOVE 'restaurante' TO '{move_data_path}', 
             MOVE 'restaurante_log' TO '{move_log_path}', 
             FILE = 1, NOUNLOAD, REPLACE, STATS = 10;
        """
        subprocess.run([
            "sqlcmd", "-S", server, "-U", user, "-P", password, "-Q", restore_command
        ], check=True)
        
        print(f"Base de datos restaurada exitosamente desde {respaldo_path} a la nueva base de datos {database}")
    except subprocess.CalledProcessError as e:
        print(f"Error al restaurar la base de datos: {e}")

def opcion9(cursor):
    print("Ejecutando Opción 9...")
    directorio_respaldo = r"E:\JERSON\UNIVERSIDAD\6 S-NIVELACION\GESTION DE BASE DE DATOS-TUTORIAS\Proyecto\Proyecto 1P\respaldos"
    archivos = listar_archivos_de_respaldo(directorio_respaldo)
    if archivos:
        try:
            seleccion = int(input("Seleccione el número del archivo de respaldo a restaurar: ")) - 1
            respaldo_path = os.path.join(directorio_respaldo, archivos[seleccion])
            nueva_db = input("Ingrese el nombre para la nueva base de datos: ")
            password = input("Ingrese la contraseña de SQL Server: ")  # Pedir al usuario la contraseña
            realizar_restauracion("localhost", nueva_db, "sa", password, respaldo_path)
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
        except ValueError:
            print("Por favor, ingrese un número válido.")

    #GENERAR PDF
def obtener_datos_tabla(cursor, tabla, columnas):
    try:
        columnas_sqlserver = ", ".join(columnas)  # Crea una cadena de las columnas para la consulta SQL
        query = f"SELECT {columnas_sqlserver} FROM {tabla}"
        cursor.execute(query)
        return cursor.fetchall()
    except Exception as e:
        print(f"Error al obtener datos de la tabla {tabla}: {e}")
        return []

def leer_incrementar_contador(archivo_contador):
    try:
        with open(archivo_contador, "r") as file:
            contador = int(file.read().strip()) + 1
    except FileNotFoundError:
        contador = 1
    with open(archivo_contador, "w") as file:
        file.write(str(contador))
    return contador

def generar_pdf_con_datos(tabla, datos, columnas, output_dir):
    # Generar un nombre de archivo único basado en la fecha y hora actuales
    fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = os.path.join(output_dir, f"{tabla}_informe_{fecha_hora}.pdf")

    doc = SimpleDocTemplate(output_path, pagesize=letter)
    story = []
    
    # Encabezados de la tabla
    data = [columnas]  # Añade los nombres de las columnas como encabezados
    
    # Agregar los datos de la tabla
    data.extend(datos)  # Añade los datos de cada fila en la base de datos
    
    # Crear la tabla con los datos
    t = Table(data)
    
    # Estilos de la tabla
    t.setStyle(TableStyle([
       ('BACKGROUND', (0,0), (-1,0), colors.gray),
       ('TEXTCOLOR', (0,0), (-1,0), colors.whitesmoke),
       ('ALIGN', (0,0), (-1,-1), 'CENTER'),
       ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
       ('BOTTOMPADDING', (0,0), (-1,0), 12),
       ('BACKGROUND', (0,1), (-1,-1), colors.beige),
       ('GRID', (0,0), (-1,-1), 1, colors.black),
       ('BOX', (0,0), (-1,-1), 2, colors.black),
    ]))
    
    story.append(t)
    doc.build(story)
    print(f"Informe generado en: {output_path}")

def obtener_detalles_tablas(cursor, database):
    """Obtiene una lista de todas las tablas y sus columnas en la base de datos especificada."""
    cursor.execute(f"""
        SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE 
        FROM {database}.INFORMATION_SCHEMA.COLUMNS 
        ORDER BY TABLE_NAME, ORDINAL_POSITION;
    """)
    result = cursor.fetchall()
    if not result:
        print("No se encontraron tablas.")
        return {}
    
    tablas = {}
    for row in result:
        if row[0] not in tablas:
            tablas[row[0]] = []
        tablas[row[0]].append((row[1], row[2]))
    return tablas

def generar_informe_completo(cursor, tablas_seleccionadas, join_condition, database):
    from_clause = f"{list(tablas_seleccionadas.keys())[0]}"
    join_clauses = " ".join([f"INNER JOIN {tabla} ON {condicion}" for tabla, condicion in join_condition.items()])
    select_clause = ", ".join([f"{tabla}.{col}" for tabla, cols in tablas_seleccionadas.items() for col in cols])
    query = f"SELECT {select_clause} FROM {from_clause} {join_clauses}"

    print(f"Generated query: {query}")  # Debugging: Output the generated query
    cursor.execute(query)
    datos = cursor.fetchall()
    columnas = [col for cols in tablas_seleccionadas.values() for col in cols]
    
    output_dir = r"E:\JERSON\UNIVERSIDAD\6 S-NIVELACION\GESTION DE BASE DE DATOS-TUTORIAS\Proyecto\Proyecto 1P\informes"
    generar_pdf_con_datos("_y_".join(tablas_seleccionadas.keys()), datos, columnas, output_dir)

def obtener_relaciones(cursor, tablas):
    if len(tablas) < 2:
        return {}  # No hay suficientes tablas para una unión

    condiciones = {}
    query = """
    SELECT fk_tab.name AS foreign_table, 
           fk_col.name AS foreign_column, 
           pk_tab.name AS primary_table, 
           pk_col.name AS primary_column
    FROM sys.foreign_keys AS fk
    INNER JOIN sys.tables AS fk_tab ON fk_tab.object_id = fk.parent_object_id
    INNER JOIN sys.tables AS pk_tab ON pk_tab.object_id = fk.referenced_object_id
    INNER JOIN sys.foreign_key_columns AS fk_cols ON fk_cols.constraint_object_id = fk.object_id
    INNER JOIN sys.columns AS fk_col ON fk_col.column_id = fk_cols.parent_column_id AND fk_col.object_id = fk_tab.object_id
    INNER JOIN sys.columns AS pk_col ON pk_col.column_id = fk_cols.referenced_column_id AND pk_col.object_id = pk_tab.object_id
    WHERE fk_tab.name IN ({}) AND pk_tab.name IN ({});
    """.format(",".join(f"'{tabla}'" for tabla in tablas), ",".join(f"'{tabla}'" for tabla in tablas))

    cursor.execute(query)
    results = cursor.fetchall()

    for res in results:
        condiciones[res[0]] = f"{res[0]}.{res[1]} = {res[2]}.{res[3]}"

    return condiciones

def opcion10(cursor):
    database = 'restaurante'
    print("Ejecutando Opción 10...")
    tablas = obtener_detalles_tablas(cursor, database)
    if not tablas:
        print("No se encontraron tablas disponibles.")
        return

    seleccion_tablas = {}
    while True:
        print("Tablas disponibles:")
        for idx, tabla in enumerate(tablas.keys(), 1):
            print(f"{idx}. {tabla}")
        
        idx_tabla = int(input("Seleccione el número de la tabla: ")) - 1
        if idx_tabla < 0 or idx_tabla >= len(tablas):
            print("Selección de tabla inválida.")
            continue
        tabla_seleccionada = list(tablas.keys())[idx_tabla]

        print("Columnas disponibles en", tabla_seleccionada, ":")
        for idx, col in enumerate(tablas[tabla_seleccionada], 1):
            print(f"{idx}. {col[0]} ({col[1]})")
        
        idxs_columnas = input("Seleccione los números de las columnas (separados por comas): ")
        columnas_seleccionadas = [tablas[tabla_seleccionada][int(i)-1][0] for i in idxs_columnas.split(",")]
        
        seleccion_tablas[tabla_seleccionada] = columnas_seleccionadas
        if input("¿Desea agregar otra tabla? (s/n): ").lower() != 's':
            break

    # Generar la condición de unión automáticamente
    join_condition = obtener_relaciones(cursor, list(seleccion_tablas.keys()))
    generar_informe_completo(cursor, seleccion_tablas, join_condition, database)

    #PROCEDIMIENTO ALMACENADO
def obtener_tablas_y_columnas(cursor):
    cursor.execute("""
        SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
        FROM INFORMATION_SCHEMA.COLUMNS
        ORDER BY TABLE_NAME, ORDINAL_POSITION;
    """)
    result = cursor.fetchall()
    tablas = {}
    for row in result:
        if row[0] not in tablas:
            tablas[row[0]] = []
        tablas[row[0]].append((row[1], row[2]))
    return tablas

def generar_procedimiento_insert(tabla, columnas):
    nombres_columnas = ", ".join([col[0] for col in columnas])
    parametros = ", ".join([f"@{col[0]} {col[1]}" for col in columnas])
    valores = ", ".join([f"@{col[0]}" for col in columnas])
    
    return f"""
CREATE PROCEDURE sp_Insert_{tabla}
    {parametros}
AS
BEGIN
    INSERT INTO {tabla} ({nombres_columnas})
    VALUES ({valores});
END;
"""

def generar_procedimiento_select(tabla, columnas):
    nombres_columnas = ", ".join([col[0] for col in columnas])
    
    return f"""
CREATE PROCEDURE sp_Select_{tabla}
AS
BEGIN
    SELECT {nombres_columnas}
    FROM {tabla};
END;
"""

def generar_procedimiento_update(tabla, columnas):
    id_columna = columnas[0][0]  # Suponiendo que la primera columna es la clave primaria
    set_clause = ", ".join([f"{col[0]} = @{col[0]}" for col in columnas if col[0] != id_columna])
    parametros = ", ".join([f"@{col[0]} {col[1]}" for col in columnas])
    
    return f"""
CREATE PROCEDURE sp_Update_{tabla}
    {parametros}
AS
BEGIN
    UPDATE {tabla}
    SET {set_clause}
    WHERE {id_columna} = @{id_columna};
END;
"""

def generar_procedimiento_delete(tabla, columna_id):
    return f"""
CREATE PROCEDURE sp_Delete_{tabla}
    @{columna_id} INT
AS
BEGIN
    DELETE FROM {tabla}
    WHERE {columna_id} = @{columna_id};
END;
"""

def generar_crud_procedimientos(tablas):
    procedimientos = ""
    for tabla, columnas in tablas.items():
        procedimientos += generar_procedimiento_insert(tabla, columnas)
        procedimientos += generar_procedimiento_select(tabla, columnas)
        procedimientos += generar_procedimiento_update(tabla, columnas)
        procedimientos += generar_procedimiento_delete(tabla, columnas[0][0])
    return procedimientos

def guardar_procedimientos_en_archivo(procedimientos, archivo_sql):
    with open(archivo_sql, "w") as file:
        file.write(procedimientos)

def opcion11(cursor):
    print("Ejecutando Opción 11...")
    tablas = obtener_tablas_y_columnas(cursor)
    procedimientos = generar_crud_procedimientos(tablas)
    
    archivo_sql = "procedimientos_crud.sql"
    guardar_procedimientos_en_archivo(procedimientos, archivo_sql)
    
    print(f"Procedimientos almacenados generados en {archivo_sql}")


def main():
    conexion = pyodbc.connect(
        "Driver={SQL Server Native Client 11.0};"
        "Server=CUENCA;"
        "Database=restaurante;"
        "UID=sa;"
        "PWD=Jerson0802;"
        "Trusted_Connection=yes"
    )
    conexion.autocommit = True  # Activar autocommit para comandos DDL como CREATE USER
    cursor = conexion.cursor()

    while True:
        mostrar_menu()
        opcion = input("Seleccione una opción: ")
        if opcion == '1':
            opcion1(cursor)
        elif opcion == '2':
            opcion2(cursor)
        elif opcion == '3':
            opcion3(cursor)
        elif opcion == '4':
            opcion4(cursor)
        elif opcion == '5':
            opcion5(cursor)
        elif opcion == '6':
            opcion6(cursor)
        elif opcion == '7':
            opcion7(cursor)
        elif opcion == '8':
            opcion8(cursor)
        elif opcion == '9':
            opcion9(cursor)
        elif opcion == '10':
            opcion10(cursor)
        elif opcion == '11':
            opcion11(cursor)
        elif opcion == '12':
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Por favor, intenta de nuevo.")

    cursor.close()
    conexion.close()

if __name__ == '__main__':
    main()