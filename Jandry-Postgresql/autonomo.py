import psycopg2
from psycopg2 import connect, sql, Error
import subprocess
import os
from datetime import datetime
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
from reportlab.lib import colors
from reportlab.pdfgen import canvas

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
    print("20. Salir")

    #CREAR USUARIOS
def crear_usuario_postgres(cursor, nombre_usuario, contraseña):
    try:
        query = sql.SQL("CREATE USER {nombre} WITH PASSWORD %s").format(nombre=sql.Identifier(nombre_usuario))
        cursor.execute(query, (contraseña,))
        print("Usuario creado exitosamente.")
    except Exception as e:
        print(f"Error al crear el usuario: {e}")

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    nombre_usuario = input("Ingrese el nombre del nuevo usuario de la base de datos: ")
    contraseña = input("Ingrese la contraseña para el nuevo usuario: ")
    crear_usuario_postgres(cursor, nombre_usuario, contraseña)

    #MOSTRAR USUARIOS
def mostrar_usuarios(cursor):
    try:
        query = """
        SELECT rolname FROM pg_roles
        WHERE rolcanlogin = TRUE
        AND rolname NOT IN ('pg_monitor', 'pg_read_all_settings', 'pg_read_all_stats', 'pg_stat_scan_tables', 'pg_signal_backend')
        ORDER BY rolname;
        """
        cursor.execute(query)
        usuarios = cursor.fetchall()
        if usuarios:
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

    #MODIFICAR USUARIOS
def cambiar_nombre_usuario(cursor, nombre_actual, nuevo_nombre):
    try:
        query = sql.SQL("ALTER ROLE {old_name} RENAME TO {new_name}").format(
            old_name=sql.Identifier(nombre_actual),
            new_name=sql.Identifier(nuevo_nombre)
        )
        cursor.execute(query)
        print("Nombre de usuario cambiado exitosamente.")
    except Exception as e:
        print(f"Error al cambiar el nombre del usuario: {e}")

def cambiar_contraseña_usuario(cursor, nombre_usuario, nueva_contraseña):
    try:
        query = sql.SQL("ALTER ROLE {name} WITH PASSWORD %s").format(
            name=sql.Identifier(nombre_usuario)
        )
        cursor.execute(query, (nueva_contraseña,))
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

    #ELIMINAR USUARIOS
def eliminar_usuario_postgres(cursor, nombre_usuario):
    try:
        query = sql.SQL("DROP ROLE {name}").format(name=sql.Identifier(nombre_usuario))
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
                eliminar_usuario_postgres(cursor, nombre_usuario)
            else:
                print("Eliminación cancelada.")
        except ValueError:
            print("Por favor, ingrese un número válido.")
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
    else:
        print("No hay usuarios para eliminar.")

    #CREAR UN ROL
def crear_rol_postgres(cursor, nombre_rol):
    try:
        query = sql.SQL("CREATE ROLE {name}").format(name=sql.Identifier(nombre_rol))
        cursor.execute(query)
        print(f"Rol '{nombre_rol}' creado exitosamente.")
    except Exception as e:
        print(f"Error al crear el rol: {e}")


def opcion5(cursor):
    print("Ejecutando Opción 5...")
    nombre_rol = input("Ingrese el nombre del nuevo rol: ")
    crear_rol_postgres(cursor, nombre_rol)

    #MOSTRAR ROLES
def mostrar_roles(cursor):
    try:
        cursor.execute("SELECT rolname FROM pg_roles WHERE rolcanlogin = FALSE AND rolname NOT IN ('pg_monitor', 'pg_read_all_settings', 'pg_read_all_stats', 'pg_stat_scan_tables', 'pg_signal_backend')")
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

    #ASIGNAR UN ROL A UN USUARIO
def asignar_rol_a_usuario(cursor, nombre_usuario, nombre_rol):
    try:
        query = sql.SQL("GRANT {role} TO {user}").format(
            role=sql.Identifier(nombre_rol),
            user=sql.Identifier(nombre_usuario)
        )
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
def realizar_respaldo(host, database, user, password, output_dir):
    try:
        # Asegurarse de que el directorio de salida existe, si no, crearlo
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
            print(f"Directorio {output_dir} creado.")
        
        # Generar nombre de archivo basado en la fecha y hora actual
        fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
        nombre_archivo = f"{database}_{fecha_hora}.dump"  # Cambiado de .sql a .dump
        output_path = os.path.join(output_dir, nombre_archivo)

        # Configurar las variables de entorno para la autenticación
        os.environ["PGHOST"] = host
        os.environ["PGDATABASE"] = database
        os.environ["PGUSER"] = user
        os.environ["PGPASSWORD"] = password

        # Ejecutar pg_dump para crear el respaldo en formato personalizado
        subprocess.run(["pg_dump", "-Fc", "-f", output_path], check=True, text=True)
        print(f"Respaldo realizado exitosamente en {output_path}")
    except Exception as e:
        print(f"Error al realizar el respaldo: {e}")

def opcion8(cursor):
    print("Ejecutando Opción 8...")
    host = "localhost"
    database = "restaurante"
    user = "postgres"
    password = "adm"
    output_dir = r"C:\Users\Jandry Moreira\Desktop\BD\respaldos"  
    realizar_respaldo(host, database, user, password, output_dir)

    #RESTAURAR BASE DE DATOS
def listar_archivos_de_respaldo(directorio_respaldo):
    archivos = [f for f in os.listdir(directorio_respaldo) if f.endswith('.dump')]
    if archivos:
        print("Archivos de respaldo disponibles:")
        for idx, archivo in enumerate(archivos, start=1):
            print(f"{idx}. {archivo}")
    else:
        print("No hay archivos de respaldo disponibles.")
    return archivos

def realizar_restauracion(host, database, user, password, respaldo_path):
    try:
        env = os.environ.copy()
        env["PGHOST"] = host
        env["PGUSER"] = user
        env["PGPASSWORD"] = password

        # Intentar eliminar la base de datos si existe
        subprocess.run([
            "psql", "-h", host, "-U", user, "-d", "postgres", "-c", 
            f"DROP DATABASE IF EXISTS {database};"
        ], check=True, text=True, env=env)

        # Crear una nueva base de datos
        subprocess.run([
            "psql", "-h", host, "-U", user, "-d", "postgres", "-c", 
            f"CREATE DATABASE {database};"
        ], check=True, text=True, env=env)
        
        # Restaurar el archivo de respaldo en la nueva base de datos
        subprocess.run([
            "pg_restore", "-h", host, "-U", user, "-d", database, respaldo_path
        ], check=True, text=True, env=env)
        print(f"Base de datos restaurada exitosamente desde {respaldo_path} a la nueva base de datos {database}")
    except subprocess.CalledProcessError as e:
        print(f"Error al restaurar la base de datos: {e}")

def opcion9(cursor):
    print("Ejecutando Opción 9...")
    directorio_respaldo = r"C:\Users\Jandry Moreira\Desktop\BD\respaldos"
    archivos = listar_archivos_de_respaldo(directorio_respaldo)
    if archivos:
        try:
            seleccion = int(input("Seleccione el número del archivo de respaldo a restaurar: ")) - 1
            respaldo_path = os.path.join(directorio_respaldo, archivos[seleccion])
            nueva_db = input("Ingrese el nombre para la nueva base de datos: ")
            password = input("Ingrese la contraseña de PostgreSQL: ")  # Pedir al usuario la contraseña
            realizar_restauracion("localhost", nueva_db, "postgres", password, respaldo_path)
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
        except ValueError:
            print("Por favor, ingrese un número válido.")

    #GENERAR PDF
def obtener_datos_tabla(cursor, tabla, columnas):
    try:
        columnas_sql = ", ".join(columnas)  # Crea una cadena de las columnas para la consulta SQL
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
    cursor.execute("""
        SELECT table_name, column_name, data_type 
        FROM information_schema.columns 
        WHERE table_schema = 'public' AND table_catalog = %s
        ORDER BY table_name, ordinal_position;
    """, (database,))
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
    from_clause = " NATURAL JOIN ".join(tablas_seleccionadas.keys())
    select_clause = ", ".join([f"{tabla}.{col}" for tabla, cols in tablas_seleccionadas.items() for col in cols])

    if join_condition:
        query = f"SELECT {select_clause} FROM {from_clause} WHERE {join_condition}"
    else:
        query = f"SELECT {select_clause} FROM {from_clause}"

    try:
        cursor.execute(query)
        datos = cursor.fetchall()
        columnas = [col for cols in tablas_seleccionadas.values() for col in cols]

        output_dir = r"C:\Users\Jandry Moreira\Desktop\BD\informes"
        generar_pdf_con_datos("_y_".join(tablas_seleccionadas.keys()), datos, columnas, output_dir)
    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")


def obtener_relaciones(cursor, tablas):
    if len(tablas) < 2:
        return ""  

    condiciones = []
    query = """
    SELECT kcu.table_name AS foreign_table, 
           kcu.column_name AS foreign_column, 
           ccu.table_name AS primary_table, 
           ccu.column_name AS primary_column
    FROM information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu 
      ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage AS ccu 
      ON ccu.constraint_name = tc.constraint_name
    WHERE tc.constraint_type = 'FOREIGN KEY' AND 
          (kcu.table_name = ANY(%s) AND ccu.table_name = ANY(%s));
    """

    # Formateamos la lista como un array de texto de PostgreSQL.
    tablas_array = "{%s}" % ','.join(tablas)  # Crea un array literal de PostgreSQL
    cursor.execute(query, (tablas_array, tablas_array))
    results = cursor.fetchall()

    for res in results:
        cond = f"{res[0]}.{res[1]} = {res[2]}.{res[3]}"
        condiciones.append(cond)

    return " AND ".join(condiciones)

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
def obtener_tablas(cursor):
    cursor.execute("""
        SELECT table_name 
        FROM information_schema.tables
        WHERE table_schema = 'public'
    """)
    return [row[0] for row in cursor.fetchall()]

def obtener_columnas(cursor, tabla):
    cursor.execute(sql.SQL("""
        SELECT column_name, data_type, column_default 
        FROM information_schema.columns 
        WHERE table_name = %s AND table_schema = 'public'
    """), [tabla])
    return cursor.fetchall()

def eliminar_procedimiento(cursor, procedimiento):
    try:
        cursor.execute(sql.SQL("DROP PROCEDURE IF EXISTS {} CASCADE").format(
            sql.Identifier(procedimiento)
        ))
    except Exception as e:
        print(f"Error al eliminar el procedimiento {procedimiento}: {e}")

def generar_procedimiento_insert(cursor, tabla, columnas):
    columnas_insertar = [col for col in columnas if col[2] is None or not col[2].startswith('nextval')]
    cols = ", ".join([col[0] for col in columnas_insertar])
    param_definitions = ", ".join([f"IN p_{col[0]} {col[1]}" for col in columnas_insertar])
    valores = ", ".join([f"p_{col[0]}" for col in columnas_insertar])
    
    eliminar_procedimiento(cursor, f"{tabla}_insert")
    
    proc_insert = f"""
    CREATE PROCEDURE {tabla}_insert({param_definitions})
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO {tabla} ({cols}) VALUES ({valores});
    END;
    $$;
    """
    cursor.execute(proc_insert)
    print(f"Procedimiento INSERT para la tabla {tabla} creado exitosamente.")

def ejecutar_procedimiento_insert(cursor, tabla, columnas):
    valores = []
    for col in columnas:
        if col[2] is None or not col[2].startswith('nextval'):  # Solo solicita el valor si no tiene valor predeterminado
            valor = input(f"Ingrese el valor para {col[0]} ({col[1]}): ")
            valores.append(valor)

    try:
        cursor.execute(sql.SQL("CALL {}({})").format(
            sql.Identifier(f"{tabla}_insert"),
            sql.SQL(", ").join(sql.Placeholder() * len(valores))
        ), valores)
        print(f"Registro insertado en la tabla {tabla}.")
    except psycopg2.errors.UniqueViolation as e:
        print(f"Error: {e}")
        cursor.execute("ROLLBACK")  # Rollback the transaction to clear the error state

def generar_procedimiento_select(cursor, tabla):
    eliminar_procedimiento(cursor, f"{tabla}_select")
    
    proc_select = f"""
    CREATE PROCEDURE {tabla}_select()
    LANGUAGE plpgsql
    AS $$
    BEGIN
        CREATE TEMP TABLE temp_result AS SELECT * FROM {tabla};
    END;
    $$;
    """
    cursor.execute(proc_select)
    print(f"Procedimiento SELECT para la tabla {tabla} creado exitosamente.")

def ejecutar_procedimiento_select(cursor, tabla):
    cursor.execute(sql.SQL("CALL {}()").format(sql.Identifier(f"{tabla}_select")))
    cursor.execute("SELECT * FROM temp_result")
    resultados = cursor.fetchall()
    for fila in resultados:
        print(fila)
    cursor.execute("DROP TABLE IF EXISTS temp_result")

def generar_procedimiento_update(cursor, tabla, columnas, id_column, id_type):
    columnas_update = [col for col in columnas if col[0] != id_column]
    param_definitions = f"IN p_{id_column} {id_type}, " + ", ".join([f"IN p_{col[0]} {col[1]}" for col in columnas_update])
    set_values = ", ".join([f"{col[0]} = p_{col[0]}" for col in columnas_update])
    
    eliminar_procedimiento(cursor, f"{tabla}_update")
    
    proc_update = f"""
    CREATE PROCEDURE {tabla}_update({param_definitions})
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE {tabla} SET {set_values} WHERE {id_column} = p_{id_column};
    END;
    $$;
    """
    cursor.execute(proc_update)
    print(f"Procedimiento UPDATE para la tabla {tabla} creado exitosamente.")

def ejecutar_procedimiento_update(cursor, tabla, columnas, id_column):
    cursor.execute(sql.SQL("SELECT * FROM {}").format(sql.Identifier(tabla)))
    registros = cursor.fetchall()
    if not registros:
        print("No hay registros disponibles para actualizar.")
        return

    print("Registros disponibles:")
    for i, registro in enumerate(registros, 1):
        print(f"{i}. {registro}")

    seleccion_registro = int(input("Seleccione el número del registro que desea actualizar: ")) - 1
    if 0 <= seleccion_registro < len(registros):
        registro_seleccionado = registros[seleccion_registro]
        id_valor = registro_seleccionado[0]  

        valores = [id_valor]
        for col in columnas:
            if col[0] != id_column:
                nuevo_valor = input(f"Ingrese el nuevo valor para {col[0]} ({col[1]}): ")
                valores.append(nuevo_valor)

        cursor.execute(sql.SQL("CALL {}({})").format(
            sql.Identifier(f"{tabla}_update"),
            sql.SQL(", ").join(sql.Placeholder() * len(valores))
        ), valores)

        print(f"Registro actualizado en la tabla {tabla}.")
    else:
        print("Selección de registro no válida. Por favor, intente de nuevo.")

def generar_procedimiento_delete(cursor, tabla, id_column, id_type):
    eliminar_procedimiento(cursor, f"{tabla}_delete")
    
    proc_delete = f"""
    CREATE PROCEDURE {tabla}_delete(IN p_{id_column} {id_type})
    LANGUAGE plpgsql
    AS $$
    BEGIN
        DELETE FROM {tabla} WHERE {id_column} = p_{id_column};
    END;
    $$;
    """
    cursor.execute(proc_delete)
    print(f"Procedimiento DELETE para la tabla {tabla} creado exitosamente.")

def ejecutar_procedimiento_delete(cursor, tabla, id_column):
    cursor.execute(sql.SQL("SELECT * FROM {}").format(sql.Identifier(tabla)))
    registros = cursor.fetchall()
    if not registros:
        print("No hay registros disponibles para eliminar.")
        return

    print("Registros disponibles:")
    for i, registro in enumerate(registros, 1):
        print(f"{i}. {registro}")

    seleccion_registro = int(input("Seleccione el número del registro que desea eliminar: ")) - 1
    if 0 <= seleccion_registro < len(registros):
        registro_seleccionado = registros[seleccion_registro]
        id_valor = registro_seleccionado[0]  

        cursor.execute(sql.SQL("CALL {}({})").format(
            sql.Identifier(f"{tabla}_delete"),
            sql.Placeholder()
        ), [id_valor])

        print(f"Registro eliminado de la tabla {tabla}.")
    else:
        print("Selección de registro no válida. Por favor, intente de nuevo.")

def es_tabla_relacion(cursor, tabla):
    relaciones = obtener_relaciones(cursor, tabla)
    columnas = obtener_columnas(cursor, tabla)
    primary_keys = [col[0] for col in columnas if col[2] is None or not col[2].startswith('nextval')]
    return len(relaciones) >= 2 and set(primary_keys) == set([rel[0] for rel in relaciones])

def solicitar_ids_relacionados(cursor, tabla):
    relaciones = obtener_relaciones(cursor, tabla)
    ids_relacionados = {}
    for relacion in relaciones:
        columna_local, tabla_externa, columna_externa = relacion
        valor = input(f"Ingrese el valor de {columna_local} relacionado con {tabla_externa}({columna_externa}): ")
        ids_relacionados[columna_local] = valor
    return ids_relacionados

def actualizar_tabla(cursor, tabla, columnas, ids_relacionados):
    set_clause = ", ".join([f"{columna} = %s" for columna in columnas])
    where_clause = " AND ".join([f"{columna} = %s" for columna in ids_relacionados.keys()])
    query = f"UPDATE {tabla} SET {set_clause} WHERE {where_clause}"
    valores = [input(f"Ingrese el nuevo valor para {columna}: ") for columna in columnas]
    valores += list(ids_relacionados.values())
    try:
        cursor.execute(query, valores)
        print("Registro actualizado exitosamente.")
    except Exception as e:
        print(f"Error al actualizar el registro: {e}")

def opcion11(cursor):
    print("Ejecutando Opción 11...")
    tablas = obtener_tablas(cursor)
    print("Tablas disponibles:")
    for i, tabla in enumerate(tablas, 1):
        print(f"{i}. {tabla}")
    
    seleccion_tabla = int(input("Seleccione el número de la tabla: ")) - 1
    if 0 <= seleccion_tabla < len(tablas):
        tabla_seleccionada = tablas[seleccion_tabla]
        columnas = obtener_columnas(cursor, tabla_seleccionada)
        
        id_column = next((col[0] for col in columnas if 'id' in col[0].lower()), None)
        id_type = next((col[1] for col in columnas if col[0] == id_column), None)

        if es_tabla_relacion(cursor, tabla_seleccionada):
            print(f"La tabla {tabla_seleccionada} es una tabla de relación muchos a muchos.")
            ids_relacionados = solicitar_ids_relacionados(cursor, tabla_seleccionada)
            print("Columnas disponibles para actualizar:")
            for i, columna in enumerate(columnas, 1):
                if columna[0] not in ids_relacionados:
                    print(f"{i}. {columna[0]}")
            
            seleccion_columnas = input("Seleccione los números de las columnas a actualizar (separados por comas): ")
            columnas_a_modificar = [columnas[int(i)-1][0] for i in seleccion_columnas.split(",") if columnas[int(i)-1][0] not in ids_relacionados]
            actualizar_tabla(cursor, tabla_seleccionada, columnas_a_modificar, ids_relacionados)
        else:
            if not id_column or not id_type:
                print(f"No se encontró una columna ID en la tabla {tabla_seleccionada}.")
                return

            print("1. Crear y ejecutar procedimiento INSERT")
            print("2. Crear y ejecutar procedimiento SELECT")
            print("3. Crear y ejecutar procedimiento UPDATE")
            print("4. Crear y ejecutar procedimiento DELETE")
            seleccion_procedimiento = int(input("Seleccione el procedimiento que desea crear y ejecutar: "))

            if seleccion_procedimiento == 1:
                generar_procedimiento_insert(cursor, tabla_seleccionada, columnas)
                ejecutar_procedimiento_insert(cursor, tabla_seleccionada, columnas)
            elif seleccion_procedimiento == 2:
                generar_procedimiento_select(cursor, tabla_seleccionada)
                ejecutar_procedimiento_select(cursor, tabla_seleccionada)
            elif seleccion_procedimiento == 3:
                generar_procedimiento_update(cursor, tabla_seleccionada, columnas, id_column, id_type)
                ejecutar_procedimiento_update(cursor, tabla_seleccionada, columnas, id_column)
            elif seleccion_procedimiento == 4:
                generar_procedimiento_delete(cursor, tabla_seleccionada, id_column, id_type)
                ejecutar_procedimiento_delete(cursor, tabla_seleccionada, id_column)
            else:
                print("Selección no válida. Por favor, intente de nuevo.")
    else:
        print("Selección de tabla no válida. Por favor, intente de nuevo.")

def main():
    database = "restaurante"
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
        elif opcion == '20':
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Por favor, intenta de nuevo.")

    cursor.close()
    conexion.close()

if __name__ == '__main__':
    main()