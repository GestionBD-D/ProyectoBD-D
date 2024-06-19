
        CREATE OR REPLACE PROCEDURE sp_create_categoria_plato(p_('ID_CATEGORIA_PLATO', 'NUMBER') NUMBER, p_('NOMBRE_CATEGORIA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO categoria_plato (id_categoria_plato, nombre_categoria)
            VALUES (p_id_categoria_plato, p_nombre_categoria);
            COMMIT;
        END sp_create_categoria_plato;
        

        CREATE OR REPLACE PROCEDURE sp_read_categoria_plato (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_categoria_plato, nombre_categoria
            FROM categoria_plato
            WHERE id_categoria_plato = p_id;
        END sp_read_categoria_plato;
        

        CREATE OR REPLACE PROCEDURE sp_update_categoria_plato (p_('ID_CATEGORIA_PLATO', 'NUMBER') NUMBER, p_('NOMBRE_CATEGORIA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE categoria_plato
            SET nombre_categoria = p_nombre_categoria
            WHERE id_categoria_plato = p_id_categoria_plato;
            COMMIT;
        END sp_update_categoria_plato;
        

        CREATE OR REPLACE PROCEDURE sp_delete_categoria_plato (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM categoria_plato
            WHERE id_categoria_plato = p_id;
            COMMIT;
        END sp_delete_categoria_plato;
        

        CREATE OR REPLACE PROCEDURE sp_create_cliente(p_('ID_CLIENTE', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('DIRECCION', 'VARCHAR2') VARCHAR2, p_('TELEFONO', 'NUMBER') NUMBER, p_('CORREO', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO cliente (id_cliente, nombre, apellido, direccion, telefono, correo)
            VALUES (p_id_cliente, p_nombre, p_apellido, p_direccion, p_telefono, p_correo);
            COMMIT;
        END sp_create_cliente;
        

        CREATE OR REPLACE PROCEDURE sp_read_cliente (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_cliente, nombre, apellido, direccion, telefono, correo
            FROM cliente
            WHERE id_cliente = p_id;
        END sp_read_cliente;
        

        CREATE OR REPLACE PROCEDURE sp_update_cliente (p_('ID_CLIENTE', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('DIRECCION', 'VARCHAR2') VARCHAR2, p_('TELEFONO', 'NUMBER') NUMBER, p_('CORREO', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE cliente
            SET nombre = p_nombre, apellido = p_apellido, direccion = p_direccion, telefono = p_telefono, correo = p_correo
            WHERE id_cliente = p_id_cliente;
            COMMIT;
        END sp_update_cliente;
        

        CREATE OR REPLACE PROCEDURE sp_delete_cliente (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM cliente
            WHERE id_cliente = p_id;
            COMMIT;
        END sp_delete_cliente;
        

        CREATE OR REPLACE PROCEDURE sp_create_cliente_queja(p_('CLIENTE_ID_CLIENTE', 'NUMBER') NUMBER, p_('QUEJA_ID_QUEJA', 'NUMBER') NUMBER, p_('DSCR_QUEJA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO cliente_queja (cliente_id_cliente, queja_id_queja, dscr_queja)
            VALUES (p_cliente_id_cliente, p_queja_id_queja, p_dscr_queja);
            COMMIT;
        END sp_create_cliente_queja;
        

        CREATE OR REPLACE PROCEDURE sp_read_cliente_queja (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT cliente_id_cliente, queja_id_queja, dscr_queja
            FROM cliente_queja
            WHERE cliente_id_cliente = p_id;
        END sp_read_cliente_queja;
        

        CREATE OR REPLACE PROCEDURE sp_update_cliente_queja (p_('CLIENTE_ID_CLIENTE', 'NUMBER') NUMBER, p_('QUEJA_ID_QUEJA', 'NUMBER') NUMBER, p_('DSCR_QUEJA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE cliente_queja
            SET queja_id_queja = p_queja_id_queja, dscr_queja = p_dscr_queja
            WHERE cliente_id_cliente = p_cliente_id_cliente;
            COMMIT;
        END sp_update_cliente_queja;
        

        CREATE OR REPLACE PROCEDURE sp_delete_cliente_queja (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM cliente_queja
            WHERE cliente_id_cliente = p_id;
            COMMIT;
        END sp_delete_cliente_queja;
        

        CREATE OR REPLACE PROCEDURE sp_create_compra(p_('ID_COMPRA', 'NUMBER') NUMBER, p_('FECHA_COMPRA', 'DATE') DATE, p_('MONTO_TOTAL', 'NUMBER') NUMBER, p_('DETALLE_COMPRA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO compra (id_compra, fecha_compra, monto_total, detalle_compra)
            VALUES (p_id_compra, p_fecha_compra, p_monto_total, p_detalle_compra);
            COMMIT;
        END sp_create_compra;
        

        CREATE OR REPLACE PROCEDURE sp_read_compra (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_compra, fecha_compra, monto_total, detalle_compra
            FROM compra
            WHERE id_compra = p_id;
        END sp_read_compra;
        

        CREATE OR REPLACE PROCEDURE sp_update_compra (p_('ID_COMPRA', 'NUMBER') NUMBER, p_('FECHA_COMPRA', 'DATE') DATE, p_('MONTO_TOTAL', 'NUMBER') NUMBER, p_('DETALLE_COMPRA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE compra
            SET fecha_compra = p_fecha_compra, monto_total = p_monto_total, detalle_compra = p_detalle_compra
            WHERE id_compra = p_id_compra;
            COMMIT;
        END sp_update_compra;
        

        CREATE OR REPLACE PROCEDURE sp_delete_compra (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM compra
            WHERE id_compra = p_id;
            COMMIT;
        END sp_delete_compra;
        

        CREATE OR REPLACE PROCEDURE sp_create_detalle_factura(p_('ID_DETALLE_FACTURA', 'NUMBER') NUMBER, p_('FACTURA_ID_FACTURA', 'NUMBER') NUMBER, p_('CANTIDAD_PRODUCTO', 'NUMBER') NUMBER, p_('PRECIO_UNITARIO', 'NUMBER') NUMBER, p_('TOTAL', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO detalle_factura (id_detalle_factura, factura_id_factura, cantidad_producto, precio_unitario, total)
            VALUES (p_id_detalle_factura, p_factura_id_factura, p_cantidad_producto, p_precio_unitario, p_total);
            COMMIT;
        END sp_create_detalle_factura;
        

        CREATE OR REPLACE PROCEDURE sp_read_detalle_factura (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_detalle_factura, factura_id_factura, cantidad_producto, precio_unitario, total
            FROM detalle_factura
            WHERE id_detalle_factura = p_id;
        END sp_read_detalle_factura;
        

        CREATE OR REPLACE PROCEDURE sp_update_detalle_factura (p_('ID_DETALLE_FACTURA', 'NUMBER') NUMBER, p_('FACTURA_ID_FACTURA', 'NUMBER') NUMBER, p_('CANTIDAD_PRODUCTO', 'NUMBER') NUMBER, p_('PRECIO_UNITARIO', 'NUMBER') NUMBER, p_('TOTAL', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE detalle_factura
            SET factura_id_factura = p_factura_id_factura, cantidad_producto = p_cantidad_producto, precio_unitario = p_precio_unitario, total = p_total
            WHERE id_detalle_factura = p_id_detalle_factura;
            COMMIT;
        END sp_update_detalle_factura;
        

        CREATE OR REPLACE PROCEDURE sp_delete_detalle_factura (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM detalle_factura
            WHERE id_detalle_factura = p_id;
            COMMIT;
        END sp_delete_detalle_factura;
        

        CREATE OR REPLACE PROCEDURE sp_create_empleado(p_('ID_EMPLEADO', 'NUMBER') NUMBER, p_('NOM_EMPLEADO', 'VARCHAR2') VARCHAR2, p_('CARGO_EMPLEADO', 'VARCHAR2') VARCHAR2, p_('TEL_EMPLEADO', 'NUMBER') NUMBER, p_('DIR_EMPLEADO', 'VARCHAR2') VARCHAR2, p_('EMAIL_EMPLEADO', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO empleado (id_empleado, nom_empleado, cargo_empleado, tel_empleado, dir_empleado, email_empleado)
            VALUES (p_id_empleado, p_nom_empleado, p_cargo_empleado, p_tel_empleado, p_dir_empleado, p_email_empleado);
            COMMIT;
        END sp_create_empleado;
        

        CREATE OR REPLACE PROCEDURE sp_read_empleado (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_empleado, nom_empleado, cargo_empleado, tel_empleado, dir_empleado, email_empleado
            FROM empleado
            WHERE id_empleado = p_id;
        END sp_read_empleado;
        

        CREATE OR REPLACE PROCEDURE sp_update_empleado (p_('ID_EMPLEADO', 'NUMBER') NUMBER, p_('NOM_EMPLEADO', 'VARCHAR2') VARCHAR2, p_('CARGO_EMPLEADO', 'VARCHAR2') VARCHAR2, p_('TEL_EMPLEADO', 'NUMBER') NUMBER, p_('DIR_EMPLEADO', 'VARCHAR2') VARCHAR2, p_('EMAIL_EMPLEADO', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE empleado
            SET nom_empleado = p_nom_empleado, cargo_empleado = p_cargo_empleado, tel_empleado = p_tel_empleado, dir_empleado = p_dir_empleado, email_empleado = p_email_empleado
            WHERE id_empleado = p_id_empleado;
            COMMIT;
        END sp_update_empleado;
        

        CREATE OR REPLACE PROCEDURE sp_delete_empleado (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM empleado
            WHERE id_empleado = p_id;
            COMMIT;
        END sp_delete_empleado;
        

        CREATE OR REPLACE PROCEDURE sp_create_factura(p_('ID_FACTURA', 'NUMBER') NUMBER, p_('ORDEN_ID_ORDEN', 'NUMBER') NUMBER, p_('FECHA_FACTURA', 'DATE') DATE, p_('ESTADO_PAGO', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO factura (id_factura, orden_id_orden, fecha_factura, estado_pago)
            VALUES (p_id_factura, p_orden_id_orden, p_fecha_factura, p_estado_pago);
            COMMIT;
        END sp_create_factura;
        

        CREATE OR REPLACE PROCEDURE sp_read_factura (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_factura, orden_id_orden, fecha_factura, estado_pago
            FROM factura
            WHERE id_factura = p_id;
        END sp_read_factura;
        

        CREATE OR REPLACE PROCEDURE sp_update_factura (p_('ID_FACTURA', 'NUMBER') NUMBER, p_('ORDEN_ID_ORDEN', 'NUMBER') NUMBER, p_('FECHA_FACTURA', 'DATE') DATE, p_('ESTADO_PAGO', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE factura
            SET orden_id_orden = p_orden_id_orden, fecha_factura = p_fecha_factura, estado_pago = p_estado_pago
            WHERE id_factura = p_id_factura;
            COMMIT;
        END sp_update_factura;
        

        CREATE OR REPLACE PROCEDURE sp_delete_factura (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM factura
            WHERE id_factura = p_id;
            COMMIT;
        END sp_delete_factura;
        

        CREATE OR REPLACE PROCEDURE sp_create_ingredientes(p_('ID_INGREDIENTES', 'NUMBER') NUMBER, p_('COMPRA_ID_COMPRA', 'NUMBER') NUMBER, p_('NOM_INGREDIENTE', 'VARCHAR2') VARCHAR2, p_('TIPO_INGREDIENTE', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO ingredientes (id_ingredientes, compra_id_compra, nom_ingrediente, tipo_ingrediente)
            VALUES (p_id_ingredientes, p_compra_id_compra, p_nom_ingrediente, p_tipo_ingrediente);
            COMMIT;
        END sp_create_ingredientes;
        

        CREATE OR REPLACE PROCEDURE sp_read_ingredientes (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_ingredientes, compra_id_compra, nom_ingrediente, tipo_ingrediente
            FROM ingredientes
            WHERE id_ingredientes = p_id;
        END sp_read_ingredientes;
        

        CREATE OR REPLACE PROCEDURE sp_update_ingredientes (p_('ID_INGREDIENTES', 'NUMBER') NUMBER, p_('COMPRA_ID_COMPRA', 'NUMBER') NUMBER, p_('NOM_INGREDIENTE', 'VARCHAR2') VARCHAR2, p_('TIPO_INGREDIENTE', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE ingredientes
            SET compra_id_compra = p_compra_id_compra, nom_ingrediente = p_nom_ingrediente, tipo_ingrediente = p_tipo_ingrediente
            WHERE id_ingredientes = p_id_ingredientes;
            COMMIT;
        END sp_update_ingredientes;
        

        CREATE OR REPLACE PROCEDURE sp_delete_ingredientes (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM ingredientes
            WHERE id_ingredientes = p_id;
            COMMIT;
        END sp_delete_ingredientes;
        

        CREATE OR REPLACE PROCEDURE sp_create_mesa(p_('ID_MESA', 'NUMBER') NUMBER, p_('EMPLEADO_ID_EMPLEADO', 'NUMBER') NUMBER, p_('CAPACIDAD', 'NUMBER') NUMBER, p_('DISPONIBILIDAD', 'NUMBER') NUMBER, p_('RESERVABLE', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO mesa (id_mesa, empleado_id_empleado, capacidad, disponibilidad, reservable)
            VALUES (p_id_mesa, p_empleado_id_empleado, p_capacidad, p_disponibilidad, p_reservable);
            COMMIT;
        END sp_create_mesa;
        

        CREATE OR REPLACE PROCEDURE sp_read_mesa (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_mesa, empleado_id_empleado, capacidad, disponibilidad, reservable
            FROM mesa
            WHERE id_mesa = p_id;
        END sp_read_mesa;
        

        CREATE OR REPLACE PROCEDURE sp_update_mesa (p_('ID_MESA', 'NUMBER') NUMBER, p_('EMPLEADO_ID_EMPLEADO', 'NUMBER') NUMBER, p_('CAPACIDAD', 'NUMBER') NUMBER, p_('DISPONIBILIDAD', 'NUMBER') NUMBER, p_('RESERVABLE', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE mesa
            SET empleado_id_empleado = p_empleado_id_empleado, capacidad = p_capacidad, disponibilidad = p_disponibilidad, reservable = p_reservable
            WHERE id_mesa = p_id_mesa;
            COMMIT;
        END sp_update_mesa;
        

        CREATE OR REPLACE PROCEDURE sp_delete_mesa (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM mesa
            WHERE id_mesa = p_id;
            COMMIT;
        END sp_delete_mesa;
        

        CREATE OR REPLACE PROCEDURE sp_create_orden(p_('ID_ORDEN', 'NUMBER') NUMBER, p_('EMPLEADO_ID_EMPLEADO', 'NUMBER') NUMBER, p_('MESA_ID_MESA', 'NUMBER') NUMBER, p_('CLIENTE_ID_CLIENTE', 'NUMBER') NUMBER, p_('ESTADO_ORDEN', 'NUMBER') NUMBER, p_('FECHA_ORDEN', 'DATE') DATE, p_('TOTAL_PAGAR', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO orden (id_orden, empleado_id_empleado, mesa_id_mesa, cliente_id_cliente, estado_orden, fecha_orden, total_pagar)
            VALUES (p_id_orden, p_empleado_id_empleado, p_mesa_id_mesa, p_cliente_id_cliente, p_estado_orden, p_fecha_orden, p_total_pagar);
            COMMIT;
        END sp_create_orden;
        

        CREATE OR REPLACE PROCEDURE sp_read_orden (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_orden, empleado_id_empleado, mesa_id_mesa, cliente_id_cliente, estado_orden, fecha_orden, total_pagar
            FROM orden
            WHERE id_orden = p_id;
        END sp_read_orden;
        

        CREATE OR REPLACE PROCEDURE sp_update_orden (p_('ID_ORDEN', 'NUMBER') NUMBER, p_('EMPLEADO_ID_EMPLEADO', 'NUMBER') NUMBER, p_('MESA_ID_MESA', 'NUMBER') NUMBER, p_('CLIENTE_ID_CLIENTE', 'NUMBER') NUMBER, p_('ESTADO_ORDEN', 'NUMBER') NUMBER, p_('FECHA_ORDEN', 'DATE') DATE, p_('TOTAL_PAGAR', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE orden
            SET empleado_id_empleado = p_empleado_id_empleado, mesa_id_mesa = p_mesa_id_mesa, cliente_id_cliente = p_cliente_id_cliente, estado_orden = p_estado_orden, fecha_orden = p_fecha_orden, total_pagar = p_total_pagar
            WHERE id_orden = p_id_orden;
            COMMIT;
        END sp_update_orden;
        

        CREATE OR REPLACE PROCEDURE sp_delete_orden (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM orden
            WHERE id_orden = p_id;
            COMMIT;
        END sp_delete_orden;
        

        CREATE OR REPLACE PROCEDURE sp_create_pago(p_('ID_PAGO', 'NUMBER') NUMBER, p_('CLIENTE_ID_CLIENTE', 'NUMBER') NUMBER, p_('METODO_PAGO', 'VARCHAR2') VARCHAR2, p_('FECHA_PAGO', 'DATE') DATE) IS
        BEGIN
            INSERT INTO pago (id_pago, cliente_id_cliente, metodo_pago, fecha_pago)
            VALUES (p_id_pago, p_cliente_id_cliente, p_metodo_pago, p_fecha_pago);
            COMMIT;
        END sp_create_pago;
        

        CREATE OR REPLACE PROCEDURE sp_read_pago (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_pago, cliente_id_cliente, metodo_pago, fecha_pago
            FROM pago
            WHERE id_pago = p_id;
        END sp_read_pago;
        

        CREATE OR REPLACE PROCEDURE sp_update_pago (p_('ID_PAGO', 'NUMBER') NUMBER, p_('CLIENTE_ID_CLIENTE', 'NUMBER') NUMBER, p_('METODO_PAGO', 'VARCHAR2') VARCHAR2, p_('FECHA_PAGO', 'DATE') DATE) IS
        BEGIN
            UPDATE pago
            SET cliente_id_cliente = p_cliente_id_cliente, metodo_pago = p_metodo_pago, fecha_pago = p_fecha_pago
            WHERE id_pago = p_id_pago;
            COMMIT;
        END sp_update_pago;
        

        CREATE OR REPLACE PROCEDURE sp_delete_pago (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM pago
            WHERE id_pago = p_id;
            COMMIT;
        END sp_delete_pago;
        

        CREATE OR REPLACE PROCEDURE sp_create_plato(p_('ID_PLATO', 'NUMBER') NUMBER, p_('CATEGORIA_ID_CATEGORIA_PLATO', 'NUMBER') NUMBER, p_('NOMBRE_PLATO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION_PLATO', 'VARCHAR2') VARCHAR2, p_('PRECIO_PLATO', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO plato (id_plato, categoria_id_categoria_plato, nombre_plato, descripcion_plato, precio_plato)
            VALUES (p_id_plato, p_categoria_id_categoria_plato, p_nombre_plato, p_descripcion_plato, p_precio_plato);
            COMMIT;
        END sp_create_plato;
        

        CREATE OR REPLACE PROCEDURE sp_read_plato (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_plato, categoria_id_categoria_plato, nombre_plato, descripcion_plato, precio_plato
            FROM plato
            WHERE id_plato = p_id;
        END sp_read_plato;
        

        CREATE OR REPLACE PROCEDURE sp_update_plato (p_('ID_PLATO', 'NUMBER') NUMBER, p_('CATEGORIA_ID_CATEGORIA_PLATO', 'NUMBER') NUMBER, p_('NOMBRE_PLATO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION_PLATO', 'VARCHAR2') VARCHAR2, p_('PRECIO_PLATO', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE plato
            SET categoria_id_categoria_plato = p_categoria_id_categoria_plato, nombre_plato = p_nombre_plato, descripcion_plato = p_descripcion_plato, precio_plato = p_precio_plato
            WHERE id_plato = p_id_plato;
            COMMIT;
        END sp_update_plato;
        

        CREATE OR REPLACE PROCEDURE sp_delete_plato (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM plato
            WHERE id_plato = p_id;
            COMMIT;
        END sp_delete_plato;
        

        CREATE OR REPLACE PROCEDURE sp_create_plato_ingredientes(p_('PLATO_ID_PLATO', 'NUMBER') NUMBER, p_('INGREDIENTES_ID_INGREDIENTES', 'NUMBER') NUMBER, p_('CANTIDAD', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO plato_ingredientes (plato_id_plato, ingredientes_id_ingredientes, cantidad)
            VALUES (p_plato_id_plato, p_ingredientes_id_ingredientes, p_cantidad);
            COMMIT;
        END sp_create_plato_ingredientes;
        

        CREATE OR REPLACE PROCEDURE sp_read_plato_ingredientes (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT plato_id_plato, ingredientes_id_ingredientes, cantidad
            FROM plato_ingredientes
            WHERE plato_id_plato = p_id;
        END sp_read_plato_ingredientes;
        

        CREATE OR REPLACE PROCEDURE sp_update_plato_ingredientes (p_('PLATO_ID_PLATO', 'NUMBER') NUMBER, p_('INGREDIENTES_ID_INGREDIENTES', 'NUMBER') NUMBER, p_('CANTIDAD', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE plato_ingredientes
            SET ingredientes_id_ingredientes = p_ingredientes_id_ingredientes, cantidad = p_cantidad
            WHERE plato_id_plato = p_plato_id_plato;
            COMMIT;
        END sp_update_plato_ingredientes;
        

        CREATE OR REPLACE PROCEDURE sp_delete_plato_ingredientes (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM plato_ingredientes
            WHERE plato_id_plato = p_id;
            COMMIT;
        END sp_delete_plato_ingredientes;
        

        CREATE OR REPLACE PROCEDURE sp_create_plato_orden(p_('PLATO_ID_PLATO', 'NUMBER') NUMBER, p_('ORDEN_ID_ORDEN', 'NUMBER') NUMBER, p_('CANTIDAD', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO plato_orden (plato_id_plato, orden_id_orden, cantidad)
            VALUES (p_plato_id_plato, p_orden_id_orden, p_cantidad);
            COMMIT;
        END sp_create_plato_orden;
        

        CREATE OR REPLACE PROCEDURE sp_read_plato_orden (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT plato_id_plato, orden_id_orden, cantidad
            FROM plato_orden
            WHERE plato_id_plato = p_id;
        END sp_read_plato_orden;
        

        CREATE OR REPLACE PROCEDURE sp_update_plato_orden (p_('PLATO_ID_PLATO', 'NUMBER') NUMBER, p_('ORDEN_ID_ORDEN', 'NUMBER') NUMBER, p_('CANTIDAD', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE plato_orden
            SET orden_id_orden = p_orden_id_orden, cantidad = p_cantidad
            WHERE plato_id_plato = p_plato_id_plato;
            COMMIT;
        END sp_update_plato_orden;
        

        CREATE OR REPLACE PROCEDURE sp_delete_plato_orden (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM plato_orden
            WHERE plato_id_plato = p_id;
            COMMIT;
        END sp_delete_plato_orden;
        

        CREATE OR REPLACE PROCEDURE sp_create_proveedor(p_('ID_PROVEEDOR', 'NUMBER') NUMBER, p_('COMPRA_ID_COMPRA', 'NUMBER') NUMBER, p_('NOM_PROVEEDOR', 'VARCHAR2') VARCHAR2, p_('TEL_PROVEEDOR', 'NUMBER') NUMBER, p_('DIR_PROVEEDOR', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO proveedor (id_proveedor, compra_id_compra, nom_proveedor, tel_proveedor, dir_proveedor)
            VALUES (p_id_proveedor, p_compra_id_compra, p_nom_proveedor, p_tel_proveedor, p_dir_proveedor);
            COMMIT;
        END sp_create_proveedor;
        

        CREATE OR REPLACE PROCEDURE sp_read_proveedor (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_proveedor, compra_id_compra, nom_proveedor, tel_proveedor, dir_proveedor
            FROM proveedor
            WHERE id_proveedor = p_id;
        END sp_read_proveedor;
        

        CREATE OR REPLACE PROCEDURE sp_update_proveedor (p_('ID_PROVEEDOR', 'NUMBER') NUMBER, p_('COMPRA_ID_COMPRA', 'NUMBER') NUMBER, p_('NOM_PROVEEDOR', 'VARCHAR2') VARCHAR2, p_('TEL_PROVEEDOR', 'NUMBER') NUMBER, p_('DIR_PROVEEDOR', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE proveedor
            SET compra_id_compra = p_compra_id_compra, nom_proveedor = p_nom_proveedor, tel_proveedor = p_tel_proveedor, dir_proveedor = p_dir_proveedor
            WHERE id_proveedor = p_id_proveedor;
            COMMIT;
        END sp_update_proveedor;
        

        CREATE OR REPLACE PROCEDURE sp_delete_proveedor (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM proveedor
            WHERE id_proveedor = p_id;
            COMMIT;
        END sp_delete_proveedor;
        

        CREATE OR REPLACE PROCEDURE sp_create_queja(p_('ID_QUEJA', 'NUMBER') NUMBER, p_('FECHA_QUEJA', 'DATE') DATE) IS
        BEGIN
            INSERT INTO queja (id_queja, fecha_queja)
            VALUES (p_id_queja, p_fecha_queja);
            COMMIT;
        END sp_create_queja;
        

        CREATE OR REPLACE PROCEDURE sp_read_queja (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_queja, fecha_queja
            FROM queja
            WHERE id_queja = p_id;
        END sp_read_queja;
        

        CREATE OR REPLACE PROCEDURE sp_update_queja (p_('ID_QUEJA', 'NUMBER') NUMBER, p_('FECHA_QUEJA', 'DATE') DATE) IS
        BEGIN
            UPDATE queja
            SET fecha_queja = p_fecha_queja
            WHERE id_queja = p_id_queja;
            COMMIT;
        END sp_update_queja;
        

        CREATE OR REPLACE PROCEDURE sp_delete_queja (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM queja
            WHERE id_queja = p_id;
            COMMIT;
        END sp_delete_queja;
        

        CREATE OR REPLACE PROCEDURE sp_create_reservacion(p_('ID_RESERVACION', 'NUMBER') NUMBER, p_('MESA_ID_MESA', 'NUMBER') NUMBER, p_('CLIENTE_ID_CLIENTE', 'NUMBER') NUMBER, p_('COMENSALES', 'NUMBER') NUMBER, p_('FECHA_RESERVACION', 'DATE') DATE) IS
        BEGIN
            INSERT INTO reservacion (id_reservacion, mesa_id_mesa, cliente_id_cliente, comensales, fecha_reservacion)
            VALUES (p_id_reservacion, p_mesa_id_mesa, p_cliente_id_cliente, p_comensales, p_fecha_reservacion);
            COMMIT;
        END sp_create_reservacion;
        

        CREATE OR REPLACE PROCEDURE sp_read_reservacion (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT id_reservacion, mesa_id_mesa, cliente_id_cliente, comensales, fecha_reservacion
            FROM reservacion
            WHERE id_reservacion = p_id;
        END sp_read_reservacion;
        

        CREATE OR REPLACE PROCEDURE sp_update_reservacion (p_('ID_RESERVACION', 'NUMBER') NUMBER, p_('MESA_ID_MESA', 'NUMBER') NUMBER, p_('CLIENTE_ID_CLIENTE', 'NUMBER') NUMBER, p_('COMENSALES', 'NUMBER') NUMBER, p_('FECHA_RESERVACION', 'DATE') DATE) IS
        BEGIN
            UPDATE reservacion
            SET mesa_id_mesa = p_mesa_id_mesa, cliente_id_cliente = p_cliente_id_cliente, comensales = p_comensales, fecha_reservacion = p_fecha_reservacion
            WHERE id_reservacion = p_id_reservacion;
            COMMIT;
        END sp_update_reservacion;
        

        CREATE OR REPLACE PROCEDURE sp_delete_reservacion (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM reservacion
            WHERE id_reservacion = p_id;
            COMMIT;
        END sp_delete_reservacion;
        