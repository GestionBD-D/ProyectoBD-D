import cx_Oracle
import subprocess
import os
from datetime import datetime
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
from reportlab.lib import colors
from shutil import copy
from shutil import copyfile

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

# CREAR USUARIOS
def crear_usuario_oracle(cursor, nombre_usuario, contraseña):
    try:
        # Agregar "C##" al nombre del usuario internamente si no lo tiene
        if not nombre_usuario.startswith("C##"):
            nombre_usuario = f"C##{nombre_usuario}"
        query = f"CREATE USER {nombre_usuario} IDENTIFIED BY {contraseña}"
        cursor.execute(query)
        query_privilegios = f"GRANT ALL PRIVILEGES TO {nombre_usuario}"
        cursor.execute(query_privilegios)
        print("Usuario creado y se le otorgaron todos los privilegios exitosamente.")
    except Exception as e:
        print(f"Error al crear el usuario: {e}")

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    nombre_usuario = input("Ingrese el nombre del nuevo usuario de la base de datos: ")
    contraseña = input("Ingrese la contraseña para el nuevo usuario: ")
    crear_usuario_oracle(cursor, nombre_usuario, contraseña)

# MOSTRAR USUARIOS
def mostrar_usuarios(cursor):
    try:
        query = """
        SELECT username FROM all_users
        WHERE username NOT IN ('SYS', 'SYSTEM')
        ORDER BY username
        """
        cursor.execute(query)
        usuarios = cursor.fetchall()
        if (usuarios):
            print("Usuarios de la base de datos:")
            for index, usuario in enumerate(usuarios, start=1):
                print(f"{index}. {usuario[0]}")
            return usuarios
        else:
            print("No hay usuarios disponibles.")
            return []
    except Exception as e:
        print(f"Error al obtener la lista de usuarios: {e}")
        return []

def opcion2(cursor):
    print("Ejecutando Opción 2...")
    mostrar_usuarios(cursor)

# MODIFICAR USUARIOS
def cambiar_nombre_usuario(cursor, nombre_actual, nuevo_nombre):
    try:
        nueva_contraseña = "Temporal123"
        
        query_crear = f"CREATE USER {nuevo_nombre} IDENTIFIED BY {nueva_contraseña}"
        cursor.execute(query_crear)
        
        query_privilegios = f"""
        SELECT privilege FROM dba_sys_privs WHERE grantee = '{nombre_actual}'
        UNION
        SELECT privilege FROM dba_tab_privs WHERE grantee = '{nombre_actual}'
        """
        cursor.execute(query_privilegios)
        privilegios = cursor.fetchall()
        for priv in privilegios:
            query_asignar_priv = f"GRANT {priv[0]} TO {nuevo_nombre}"
            cursor.execute(query_asignar_priv)

        query_eliminar = f"DROP USER {nombre_actual} CASCADE"
        cursor.execute(query_eliminar)
        
        print(f"Usuario {nombre_actual} renombrado a {nuevo_nombre} y eliminado exitosamente.")
    except Exception as e:
        print(f"Error al cambiar el nombre del usuario: {e}")
        print(f"Error al cambiar el nombre del usuario: {e}")

def cambiar_contraseña_usuario(cursor, nombre_usuario, nueva_contraseña):
    try:
        query = f"ALTER USER {nombre_usuario} IDENTIFIED BY {nueva_contraseña}"
        cursor.execute(query)
        print("Contraseña cambiada exitosamente.")
    except Exception as e:
        print(f"Error al cambiar la contraseña del usuario: {e}")
def opcion3(cursor):
    print("Ejecutando Opción 3...")
    usuarios = mostrar_usuarios(cursor)
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

# ELIMINAR USUARIOS
def eliminar_usuario_oracle(cursor, nombre_usuario):
    try:
        query = f"DROP USER {nombre_usuario} CASCADE"
        cursor.execute(query)
        print("Usuario eliminado exitosamente.")
    except Exception as e:
        print(f"Error al eliminar el usuario: {e}")

def opcion4(cursor):
    print("Ejecutando Opción 4...")
    usuarios = mostrar_usuarios(cursor)
    if usuarios:
        try:
            eleccion = int(input("Seleccione el número del usuario a eliminar: "))
            nombre_usuario = usuarios[eleccion - 1][0]
            confirmacion = input(f"Está seguro de que desea eliminar al usuario '{nombre_usuario}'? (s/n): ")
            if confirmacion.lower() == 's':
                eliminar_usuario_oracle(cursor, nombre_usuario)
            else:
                print("Eliminación cancelada.")
        except ValueError:
            print("Por favor, ingrese un número válido.")
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
    else:
        print("No hay usuarios para eliminar.")

# CREAR UN ROL
def crear_rol_oracle(cursor, nombre_rol):
    try:
        if not nombre_rol.startswith("C##"):
            nombre_rol = f"C##{nombre_rol}"
        query = f"CREATE ROLE {nombre_rol}"
        cursor.execute(query)
        print(f"Rol '{nombre_rol}' creado exitosamente.")
    except Exception as e:
        print(f"Error al crear el rol: {e}")

def opcion5(cursor):
    print("Ejecutando Opción 5...")
    nombre_rol = input("Ingrese el nombre del nuevo rol: ")
    crear_rol_oracle(cursor, nombre_rol)

# MOSTRAR ROLES
def mostrar_roles(cursor):
    try:
        cursor.execute("SELECT role FROM dba_roles ORDER BY role")
        roles = cursor.fetchall()
        if roles:
            print("Roles disponibles en la base de datos:")
            for index, rol in enumerate(roles, start=1):
                print(f"{index}. {rol[0]}")
            return roles
        else:
            print("No hay roles disponibles.")
            return []
    except Exception as e:
        print(f"Error al obtener la lista de roles: {e}")
        return []

def opcion6(cursor):
    print("Ejecutando Opción 6...")
    mostrar_roles(cursor)

# ASIGNAR UN ROL A UN USUARIO
def asignar_rol_a_usuario(cursor, nombre_usuario, nombre_rol):
    try:
        query = f"GRANT {nombre_rol} TO {nombre_usuario}"
        cursor.execute(query)
        print(f"Rol '{nombre_rol}' asignado exitosamente a '{nombre_usuario}'.")
    except Exception as e:
        print(f"Error al asignar el rol: {e}")

def opcion7(cursor):
    print("Ejecutando Opción 7...")
    usuarios = mostrar_usuarios(cursor)
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

    roles = mostrar_roles(cursor)
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

    asignar_rol_a_usuario(cursor, nombre_usuario, nombre_rol)

#RESPALDO DE BASE DE DATOS
def realizar_respaldo(user, password, tnsname, directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
            print(f"Directorio {directory} creado.")

        fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
        nombre_archivo = f"{tnsname}_{fecha_hora}.dmp"
        archivo_log = f"{tnsname}_{fecha_hora}.log"
        
        command = f"expdp {user}/{password}@{tnsname} directory=DATA_PUMP_DIR dumpfile={nombre_archivo} logfile={archivo_log}"
        print(f"Ejecutando comando: {command}")
        subprocess.run(command, shell=True, check=True)

        # Ruta en DATA_PUMP_DIR (asegúrese de que la ruta sea correcta)
        path_respaldo_oracle = os.path.join(r"C:\app\oracle\admin\XE\dpdump", nombre_archivo)
        path_log_oracle = os.path.join(r"C:\app\oracle\admin\XE\dpdump", archivo_log)
        
        # Ruta de destino
        path_respaldo_destino = os.path.join(directory, nombre_archivo)
        path_log_destino = os.path.join(directory, archivo_log)

        # Copiar el archivo de respaldo y el archivo de log al directorio de destino
        copyfile(path_respaldo_oracle, path_respaldo_destino)
        copyfile(path_log_oracle, path_log_destino)
        
        print(f"Respaldo realizado exitosamente y copiado a {path_respaldo_destino}")
    except Exception as e:
        print(f"Error al realizar el respaldo: {e}")

def opcion8(cursor):
    print("Ejecutando Opción 8...")
    user = "rest"  # Cambiar por el usuario de Oracle
    password = "adm"  # Cambiar por la contraseña de Oracle
    tnsname = "xe"  # Cambiar por el TNS alias
    directory = r"C:\BD\respaldos"  # Directorio para respaldo
    realizar_respaldo(user, password, tnsname, directory)

def actualizar_contraseña_usuario(cursor, nombre_usuario, nueva_contraseña):
    try:
        query = f"ALTER USER {nombre_usuario} IDENTIFIED BY {nueva_contraseña}"
        cursor.execute(query)
        print("Contraseña actualizada exitosamente.")
    except Exception as e:
        print(f"Error al actualizar la contraseña: {e}")

def crear_usuario_si_no_existe(cursor, nombre_usuario, contraseña):
    try:
        query = f"SELECT COUNT(*) FROM all_users WHERE username = '{nombre_usuario.upper()}'"
        cursor.execute(query)
        usuario_existe = cursor.fetchone()[0]
        if usuario_existe == 0:
            crear_usuario_oracle(cursor, nombre_usuario, contraseña)
        else:
            print(f"El usuario {nombre_usuario} ya existe.")
    except Exception as e:
        print(f"Error al verificar/crear el usuario: {e}")

def listar_archivos_respaldo(directorio):
    try:
        archivos = [f for f in os.listdir(directorio) if f.endswith('.dmp')]
        if archivos:
            print("Archivos de respaldo disponibles:")
            for idx, archivo in enumerate(archivos, 1):
                print(f"{idx}. {archivo}")
            return archivos
        else:
            print("No se encontraron archivos de respaldo en el directorio especificado.")
            return []
    except Exception as e:
        print(f"Error al listar archivos de respaldo: {e}")
        return []

def obtener_esquema_original(user, password, tnsname, archivo_respaldo):
    try:
        sqlfile = "temp_sqlfile.sql"
        command = f"impdp {user}/{password}@{tnsname} directory=DATA_PUMP_DIR dumpfile={archivo_respaldo} sqlfile={sqlfile}"
        print(f"Ejecutando comando: {command}")
        subprocess.run(command, shell=True, check=True)
        
        # Ruta completa del archivo SQL
        sqlfile_path = os.path.join("C:\\ORACLE\\ADMIN\\XE\\DPDUMP", sqlfile)
        
        # Asegurarse de que el archivo SQL se ha creado
        if not os.path.isfile(sqlfile_path):
            print("No se pudo encontrar el archivo SQL generado.")
            return None
        
        # Leer y analizar el archivo SQL
        esquema_original = None
        with open(sqlfile_path, 'r') as file:
            lines = file.readlines()
            print("Contenido del archivo SQL:")
            for i, line in enumerate(lines[:20]):  # Imprimir las primeras 20 líneas para depuración
                print(f"{i + 1}: {line.strip()}")
                if "CREATE TABLE" in line or "CREATE USER" in line or "ALTER USER" in line:
                    esquema_original = line.split('"')[1]
                    print(f"Esquema original determinado: {esquema_original}")
                    break
        
        if not esquema_original:
            print("No se pudo encontrar el esquema original en el archivo SQL.")
        return esquema_original
    except Exception as e:
        print(f"Error al obtener el esquema original: {e}")
    return None

def restaurar_base_datos(user, password, tnsname, archivo_respaldo, esquema_original, usuario_destino):
    try:
        command = f"impdp {user}/{password}@{tnsname} directory=DATA_PUMP_DIR dumpfile={archivo_respaldo} remap_schema={esquema_original}:{usuario_destino} table_exists_action=replace"
        print(f"Ejecutando comando: {command}")
        subprocess.run(command, shell=True, check=True)
        print(f"Restauración de la base de datos desde {archivo_respaldo} en el usuario {usuario_destino} completada exitosamente.")
    except subprocess.CalledProcessError as e:
        print(f"Error al restaurar la base de datos: {e}")
    except Exception as e:
        print(f"Error inesperado al restaurar la base de datos: {e}")

def opcion9(cursor):
    print("Ejecutando Opción 9...")
    
    # Especifica el directorio donde se encuentran los respaldos
    directorio_respaldo = r"C:\BD\respaldos"
    
    # Listar archivos de respaldo disponibles
    archivos_respaldo = listar_archivos_respaldo(directorio_respaldo)
    if not archivos_respaldo:
        return
    
    try:
        idx_archivo = int(input("Seleccione el número del archivo de respaldo a utilizar: ")) - 1
        archivo_seleccionado = archivos_respaldo[idx_archivo]
    except (ValueError, IndexError):
        print("Selección no válida. Por favor, ingrese un número válido.")
        return
    
    # Listar usuarios disponibles en la base de datos
    usuarios = mostrar_usuarios(cursor)
    if not usuarios:
        return
    
    try:
        idx_usuario = int(input("Seleccione el número del usuario destino para la restauración: ")) - 1
        usuario_destino = usuarios[idx_usuario][0]
    except (ValueError, IndexError):
        print("Selección no válida. Por favor, ingrese un número válido.")
        return

    # Datos de conexión
    user = "system"  # Cambiar por el usuario de Oracle
    password = "adm"  # Cambiar por la contraseña de Oracle
    tnsname = "xe"  # Cambiar por el TNS alias

    # Asegurarse de que el usuario destino existe
    nueva_contraseña = "NuevaContraseña123"  # Define una contraseña válida
    crear_usuario_si_no_existe(cursor, usuario_destino, nueva_contraseña)
    
    # Actualizar la contraseña del usuario Oracle
    actualizar_contraseña_usuario(cursor, "rest", "adm")  # Contraseña nueva para el usuario system

    # Obtener el esquema original
    esquema_original = obtener_esquema_original(user, password, tnsname, archivo_seleccionado)
    if not esquema_original:
        print("No se pudo determinar el esquema original.")
        return

    # Realizar la restauración
    restaurar_base_datos(user, password, tnsname, archivo_seleccionado, esquema_original, usuario_destino)




#GENERAR PDF
def obtener_datos_tabla(cursor, tabla, columnas):
    try:
        columnas_sql = ", ".join(columnas)
        query = f"SELECT {columnas_sql} FROM {tabla}"
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
    fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = os.path.join(output_dir, f"{tabla}_informe_{fecha_hora}.pdf")

    doc = SimpleDocTemplate(output_path, pagesize=letter)
    story = []
    
    data = [columnas]
    data.extend(datos)
    
    t = Table(data)
    
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

def obtener_detalles_tablas(cursor, schema):
    try:
        print(f"Verificando tablas en el esquema: {schema.upper()}")
        cursor.execute("""
            SELECT table_name, column_name, data_type 
            FROM all_tab_columns 
            WHERE owner = :owner
            ORDER BY table_name, column_id
        """, {"owner": schema.upper()})
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
    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")
        return {}

def generar_informe_completo(cursor, tablas_seleccionadas, join_condition, schema):
    from_clause = ", ".join([f"{schema}.{tabla}" for tabla in tablas_seleccionadas.keys()])
    select_clause = ", ".join([f"{schema}.{tabla}.{col}" for tabla, cols in tablas_seleccionadas.items() for col in cols])

    if join_condition:
        query = f"SELECT {select_clause} FROM {from_clause} WHERE {join_condition}"
    else:
        query = f"SELECT {select_clause} FROM {from_clause}"

    try:
        print(f"Ejecutando consulta: {query}")  # Añadir impresión de la consulta para depuración
        cursor.execute(query)
        datos = cursor.fetchall()
        columnas = [col for cols in tablas_seleccionadas.values() for col in cols]

        output_dir = "C:/BD/informes"
        generar_pdf_con_datos("_y_".join(tablas_seleccionadas.keys()), datos, columnas, output_dir)
    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")

def obtener_relaciones(cursor, tablas):
    if len(tablas) < 2:
        return ""  # No hay suficientes tablas para una unión

    condiciones = []
    tablas_str = ", ".join([f"'{tabla}'" for tabla in tablas])
    query = f"""
    SELECT a.table_name AS foreign_table, a.column_name AS foreign_column, 
           b.table_name AS primary_table, b.column_name AS primary_column
    FROM all_cons_columns a
    JOIN all_constraints c ON a.constraint_name = c.constraint_name
    JOIN all_cons_columns b ON c.r_constraint_name = b.constraint_name
    WHERE c.constraint_type = 'R' 
      AND a.table_name IN ({tablas_str})
      AND b.table_name IN ({tablas_str})
    """

    cursor.execute(query)
    results = cursor.fetchall()

    for res in results:
        cond = f"{res[0]}.{res[1]} = {res[2]}.{res[3]}"
        condiciones.append(cond)

    return " AND ".join(condiciones)

def opcion10(cursor):
    schema = 'rest'  # Cambiar por el esquema correcto en tu base de datos Oracle
    print("Ejecutando Opción 10...")
    tablas = obtener_detalles_tablas(cursor, schema)
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

    join_condition = obtener_relaciones(cursor, list(seleccion_tablas.keys()))
    generar_informe_completo(cursor, seleccion_tablas, join_condition, schema)


##CRUD
def obtener_detalles_tablas(cursor, schema):
    try:
        cursor.execute("""
            SELECT table_name, column_name, data_type 
            FROM all_tab_columns 
            WHERE owner = :owner
            ORDER BY table_name, column_id
        """, {"owner": schema.upper()})
        result = cursor.fetchall()
        tablas = {}
        for row in result:
            if row[0] not in tablas:
                tablas[row[0]] = []
            tablas[row[0]].append((row[1], row[2]))
        return tablas
    except Exception as e:
        print(f"Error al obtener detalles de las tablas: {e}")
        return {}

def generar_procedimientos_crud(tablas):
    procedimientos = []
    for tabla, columnas in tablas.items():
        nombre_tabla = tabla.lower()
        cols = [col[0].lower() for col in columnas]
        cols_str = ", ".join(cols)
        params_str = ", ".join([f"p_{col} {col[1]}" for col in columnas])
        
        # Procedimiento CREATE
        procedimientos.append(f"""
        CREATE OR REPLACE PROCEDURE sp_create_{nombre_tabla}({params_str}) IS
        BEGIN
            INSERT INTO {nombre_tabla} ({cols_str})
            VALUES ({", ".join([f"p_{col}" for col in cols])});
            COMMIT;
        END sp_create_{nombre_tabla};
        """)

        # Procedimiento READ
        procedimientos.append(f"""
        CREATE OR REPLACE PROCEDURE sp_read_{nombre_tabla} (p_id IN {columnas[0][1]}, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT {cols_str}
            FROM {nombre_tabla}
            WHERE {cols[0]} = p_id;
        END sp_read_{nombre_tabla};
        """)

        # Procedimiento UPDATE
        set_clause = ", ".join([f"{col} = p_{col}" for col in cols[1:]])
        procedimientos.append(f"""
        CREATE OR REPLACE PROCEDURE sp_update_{nombre_tabla} ({params_str}) IS
        BEGIN
            UPDATE {nombre_tabla}
            SET {set_clause}
            WHERE {cols[0]} = p_{cols[0]};
            COMMIT;
        END sp_update_{nombre_tabla};
        """)

        # Procedimiento DELETE
        procedimientos.append(f"""
        CREATE OR REPLACE PROCEDURE sp_delete_{nombre_tabla} (p_id IN {columnas[0][1]}) IS
        BEGIN
            DELETE FROM {nombre_tabla}
            WHERE {cols[0]} = p_id;
            COMMIT;
        END sp_delete_{nombre_tabla};
        """)
    return "\n".join(procedimientos)

def guardar_procedimientos_en_archivo(procedimientos, archivo_sql):
    with open(archivo_sql, "w") as file:
        file.write(procedimientos)
    print(f"Procedimientos almacenados generados en el archivo: {archivo_sql}")

def opcion11(cursor):
    print("Ejecutando opción 11...")
    schema = 'rest'  # Cambiar al esquema correspondiente
    tablas = obtener_detalles_tablas(cursor, schema)
    if tablas:
        procedimientos = generar_procedimientos_crud(tablas)
        guardar_procedimientos_en_archivo(procedimientos, "procedimientos_crud.sql")
    else:
        print("No se encontraron tablas en el esquema especificado.")



def main():
    dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='xe')
    conexion = cx_Oracle.connect(user='system', password='adm', dsn=dsn_tns)
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