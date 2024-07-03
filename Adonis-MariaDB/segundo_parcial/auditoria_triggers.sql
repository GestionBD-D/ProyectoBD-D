
    CREATE OR REPLACE TRIGGER audit_categoria_plato_after_insert
    AFTER INSERT ON categoria_plato
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('categoria_plato', USER(), 'INSERT', JSON_OBJECT('new_id_categoria_plato', NEW.ID_CATEGORIA_PLATO, 'new_nombre_categoria', NEW.NOMBRE_CATEGORIA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_categoria_plato_after_update
    AFTER UPDATE ON categoria_plato
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('categoria_plato', USER(), 'UPDATE', JSON_OBJECT('old_id_categoria_plato', OLD.ID_CATEGORIA_PLATO, 'new_id_categoria_plato', NEW.ID_CATEGORIA_PLATO, 'old_nombre_categoria', OLD.NOMBRE_CATEGORIA, 'new_nombre_categoria', NEW.NOMBRE_CATEGORIA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_categoria_plato_after_delete
    AFTER DELETE ON categoria_plato
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('categoria_plato', USER(), 'DELETE', JSON_OBJECT('old_id_categoria_plato', OLD.ID_CATEGORIA_PLATO, 'old_nombre_categoria', OLD.NOMBRE_CATEGORIA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_cliente_after_insert
    AFTER INSERT ON cliente
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('cliente', USER(), 'INSERT', JSON_OBJECT('new_id_cliente', NEW.ID_CLIENTE, 'new_nombre', NEW.NOMBRE, 'new_apellido', NEW.APELLIDO, 'new_direccion', NEW.DIRECCION, 'new_telefono', NEW.TELEFONO, 'new_correo', NEW.CORREO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_cliente_after_update
    AFTER UPDATE ON cliente
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('cliente', USER(), 'UPDATE', JSON_OBJECT('old_id_cliente', OLD.ID_CLIENTE, 'new_id_cliente', NEW.ID_CLIENTE, 'old_nombre', OLD.NOMBRE, 'new_nombre', NEW.NOMBRE, 'old_apellido', OLD.APELLIDO, 'new_apellido', NEW.APELLIDO, 'old_direccion', OLD.DIRECCION, 'new_direccion', NEW.DIRECCION, 'old_telefono', OLD.TELEFONO, 'new_telefono', NEW.TELEFONO, 'old_correo', OLD.CORREO, 'new_correo', NEW.CORREO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_cliente_after_delete
    AFTER DELETE ON cliente
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('cliente', USER(), 'DELETE', JSON_OBJECT('old_id_cliente', OLD.ID_CLIENTE, 'old_nombre', OLD.NOMBRE, 'old_apellido', OLD.APELLIDO, 'old_direccion', OLD.DIRECCION, 'old_telefono', OLD.TELEFONO, 'old_correo', OLD.CORREO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_cliente_queja_after_insert
    AFTER INSERT ON cliente_queja
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('cliente_queja', USER(), 'INSERT', JSON_OBJECT('new_cliente_id_cliente', NEW.CLIENTE_ID_CLIENTE, 'new_queja_id_queja', NEW.QUEJA_ID_QUEJA, 'new_descripcion', NEW.DESCRIPCION));
    END;
    


    CREATE OR REPLACE TRIGGER audit_cliente_queja_after_update
    AFTER UPDATE ON cliente_queja
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('cliente_queja', USER(), 'UPDATE', JSON_OBJECT('old_cliente_id_cliente', OLD.CLIENTE_ID_CLIENTE, 'new_cliente_id_cliente', NEW.CLIENTE_ID_CLIENTE, 'old_queja_id_queja', OLD.QUEJA_ID_QUEJA, 'new_queja_id_queja', NEW.QUEJA_ID_QUEJA, 'old_descripcion', OLD.DESCRIPCION, 'new_descripcion', NEW.DESCRIPCION));
    END;
    


    CREATE OR REPLACE TRIGGER audit_cliente_queja_after_delete
    AFTER DELETE ON cliente_queja
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('cliente_queja', USER(), 'DELETE', JSON_OBJECT('old_cliente_id_cliente', OLD.CLIENTE_ID_CLIENTE, 'old_queja_id_queja', OLD.QUEJA_ID_QUEJA, 'old_descripcion', OLD.DESCRIPCION));
    END;
    


    CREATE OR REPLACE TRIGGER audit_compra_after_insert
    AFTER INSERT ON compra
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('compra', USER(), 'INSERT', JSON_OBJECT('new_id_compra', NEW.ID_COMPRA, 'new_fecha_compra', NEW.FECHA_COMPRA, 'new_monto_total', NEW.MONTO_TOTAL, 'new_detalle_compra', NEW.DETALLE_COMPRA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_compra_after_update
    AFTER UPDATE ON compra
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('compra', USER(), 'UPDATE', JSON_OBJECT('old_id_compra', OLD.ID_COMPRA, 'new_id_compra', NEW.ID_COMPRA, 'old_fecha_compra', OLD.FECHA_COMPRA, 'new_fecha_compra', NEW.FECHA_COMPRA, 'old_monto_total', OLD.MONTO_TOTAL, 'new_monto_total', NEW.MONTO_TOTAL, 'old_detalle_compra', OLD.DETALLE_COMPRA, 'new_detalle_compra', NEW.DETALLE_COMPRA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_compra_after_delete
    AFTER DELETE ON compra
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('compra', USER(), 'DELETE', JSON_OBJECT('old_id_compra', OLD.ID_COMPRA, 'old_fecha_compra', OLD.FECHA_COMPRA, 'old_monto_total', OLD.MONTO_TOTAL, 'old_detalle_compra', OLD.DETALLE_COMPRA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_detalle_factura_after_insert
    AFTER INSERT ON detalle_factura
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('detalle_factura', USER(), 'INSERT', JSON_OBJECT('new_id_detalle_factura', NEW.ID_DETALLE_FACTURA, 'new_factura_id_factura', NEW.FACTURA_ID_FACTURA, 'new_cantidad_producto', NEW.CANTIDAD_PRODUCTO, 'new_precio_unitario', NEW.PRECIO_UNITARIO, 'new_total', NEW.TOTAL));
    END;
    


    CREATE OR REPLACE TRIGGER audit_detalle_factura_after_update
    AFTER UPDATE ON detalle_factura
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('detalle_factura', USER(), 'UPDATE', JSON_OBJECT('old_id_detalle_factura', OLD.ID_DETALLE_FACTURA, 'new_id_detalle_factura', NEW.ID_DETALLE_FACTURA, 'old_factura_id_factura', OLD.FACTURA_ID_FACTURA, 'new_factura_id_factura', NEW.FACTURA_ID_FACTURA, 'old_cantidad_producto', OLD.CANTIDAD_PRODUCTO, 'new_cantidad_producto', NEW.CANTIDAD_PRODUCTO, 'old_precio_unitario', OLD.PRECIO_UNITARIO, 'new_precio_unitario', NEW.PRECIO_UNITARIO, 'old_total', OLD.TOTAL, 'new_total', NEW.TOTAL));
    END;
    


    CREATE OR REPLACE TRIGGER audit_detalle_factura_after_delete
    AFTER DELETE ON detalle_factura
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('detalle_factura', USER(), 'DELETE', JSON_OBJECT('old_id_detalle_factura', OLD.ID_DETALLE_FACTURA, 'old_factura_id_factura', OLD.FACTURA_ID_FACTURA, 'old_cantidad_producto', OLD.CANTIDAD_PRODUCTO, 'old_precio_unitario', OLD.PRECIO_UNITARIO, 'old_total', OLD.TOTAL));
    END;
    


    CREATE OR REPLACE TRIGGER audit_empleado_after_insert
    AFTER INSERT ON empleado
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('empleado', USER(), 'INSERT', JSON_OBJECT('new_id_empleado', NEW.ID_EMPLEADO, 'new_nombre', NEW.NOMBRE, 'new_cargo', NEW.CARGO, 'new_telefono', NEW.TELEFONO, 'new_direccion', NEW.DIRECCION, 'new_correo', NEW.CORREO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_empleado_after_update
    AFTER UPDATE ON empleado
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('empleado', USER(), 'UPDATE', JSON_OBJECT('old_id_empleado', OLD.ID_EMPLEADO, 'new_id_empleado', NEW.ID_EMPLEADO, 'old_nombre', OLD.NOMBRE, 'new_nombre', NEW.NOMBRE, 'old_cargo', OLD.CARGO, 'new_cargo', NEW.CARGO, 'old_telefono', OLD.TELEFONO, 'new_telefono', NEW.TELEFONO, 'old_direccion', OLD.DIRECCION, 'new_direccion', NEW.DIRECCION, 'old_correo', OLD.CORREO, 'new_correo', NEW.CORREO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_empleado_after_delete
    AFTER DELETE ON empleado
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('empleado', USER(), 'DELETE', JSON_OBJECT('old_id_empleado', OLD.ID_EMPLEADO, 'old_nombre', OLD.NOMBRE, 'old_cargo', OLD.CARGO, 'old_telefono', OLD.TELEFONO, 'old_direccion', OLD.DIRECCION, 'old_correo', OLD.CORREO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_factura_after_insert
    AFTER INSERT ON factura
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('factura', USER(), 'INSERT', JSON_OBJECT('new_id_factura', NEW.ID_FACTURA, 'new_orden_id_orden', NEW.ORDEN_ID_ORDEN, 'new_fecha_factura', NEW.FECHA_FACTURA, 'new_estado_pago', NEW.ESTADO_PAGO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_factura_after_update
    AFTER UPDATE ON factura
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('factura', USER(), 'UPDATE', JSON_OBJECT('old_id_factura', OLD.ID_FACTURA, 'new_id_factura', NEW.ID_FACTURA, 'old_orden_id_orden', OLD.ORDEN_ID_ORDEN, 'new_orden_id_orden', NEW.ORDEN_ID_ORDEN, 'old_fecha_factura', OLD.FECHA_FACTURA, 'new_fecha_factura', NEW.FECHA_FACTURA, 'old_estado_pago', OLD.ESTADO_PAGO, 'new_estado_pago', NEW.ESTADO_PAGO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_factura_after_delete
    AFTER DELETE ON factura
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('factura', USER(), 'DELETE', JSON_OBJECT('old_id_factura', OLD.ID_FACTURA, 'old_orden_id_orden', OLD.ORDEN_ID_ORDEN, 'old_fecha_factura', OLD.FECHA_FACTURA, 'old_estado_pago', OLD.ESTADO_PAGO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_ingredientes_after_insert
    AFTER INSERT ON ingredientes
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('ingredientes', USER(), 'INSERT', JSON_OBJECT('new_id_ingredientes', NEW.ID_INGREDIENTES, 'new_compra_id_compra', NEW.COMPRA_ID_COMPRA, 'new_nombre', NEW.NOMBRE, 'new_tipo', NEW.TIPO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_ingredientes_after_update
    AFTER UPDATE ON ingredientes
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('ingredientes', USER(), 'UPDATE', JSON_OBJECT('old_id_ingredientes', OLD.ID_INGREDIENTES, 'new_id_ingredientes', NEW.ID_INGREDIENTES, 'old_compra_id_compra', OLD.COMPRA_ID_COMPRA, 'new_compra_id_compra', NEW.COMPRA_ID_COMPRA, 'old_nombre', OLD.NOMBRE, 'new_nombre', NEW.NOMBRE, 'old_tipo', OLD.TIPO, 'new_tipo', NEW.TIPO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_ingredientes_after_delete
    AFTER DELETE ON ingredientes
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('ingredientes', USER(), 'DELETE', JSON_OBJECT('old_id_ingredientes', OLD.ID_INGREDIENTES, 'old_compra_id_compra', OLD.COMPRA_ID_COMPRA, 'old_nombre', OLD.NOMBRE, 'old_tipo', OLD.TIPO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_mesa_after_insert
    AFTER INSERT ON mesa
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('mesa', USER(), 'INSERT', JSON_OBJECT('new_id_mesa', NEW.ID_MESA, 'new_empleado_id_empleado', NEW.EMPLEADO_ID_EMPLEADO, 'new_capacidad', NEW.CAPACIDAD, 'new_disponibilidad', NEW.DISPONIBILIDAD, 'new_reservable', NEW.RESERVABLE));
    END;
    


    CREATE OR REPLACE TRIGGER audit_mesa_after_update
    AFTER UPDATE ON mesa
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('mesa', USER(), 'UPDATE', JSON_OBJECT('old_id_mesa', OLD.ID_MESA, 'new_id_mesa', NEW.ID_MESA, 'old_empleado_id_empleado', OLD.EMPLEADO_ID_EMPLEADO, 'new_empleado_id_empleado', NEW.EMPLEADO_ID_EMPLEADO, 'old_capacidad', OLD.CAPACIDAD, 'new_capacidad', NEW.CAPACIDAD, 'old_disponibilidad', OLD.DISPONIBILIDAD, 'new_disponibilidad', NEW.DISPONIBILIDAD, 'old_reservable', OLD.RESERVABLE, 'new_reservable', NEW.RESERVABLE));
    END;
    


    CREATE OR REPLACE TRIGGER audit_mesa_after_delete
    AFTER DELETE ON mesa
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('mesa', USER(), 'DELETE', JSON_OBJECT('old_id_mesa', OLD.ID_MESA, 'old_empleado_id_empleado', OLD.EMPLEADO_ID_EMPLEADO, 'old_capacidad', OLD.CAPACIDAD, 'old_disponibilidad', OLD.DISPONIBILIDAD, 'old_reservable', OLD.RESERVABLE));
    END;
    


    CREATE OR REPLACE TRIGGER audit_orden_after_insert
    AFTER INSERT ON orden
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('orden', USER(), 'INSERT', JSON_OBJECT('new_id_orden', NEW.ID_ORDEN, 'new_empleado_id_empleado', NEW.EMPLEADO_ID_EMPLEADO, 'new_mesa_id_mesa', NEW.MESA_ID_MESA, 'new_cliente_id_cliente', NEW.CLIENTE_ID_CLIENTE, 'new_estado_orden', NEW.ESTADO_ORDEN, 'new_fecha_orden', NEW.FECHA_ORDEN, 'new_total_pagar', NEW.TOTAL_PAGAR));
    END;
    


    CREATE OR REPLACE TRIGGER audit_orden_after_update
    AFTER UPDATE ON orden
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('orden', USER(), 'UPDATE', JSON_OBJECT('old_id_orden', OLD.ID_ORDEN, 'new_id_orden', NEW.ID_ORDEN, 'old_empleado_id_empleado', OLD.EMPLEADO_ID_EMPLEADO, 'new_empleado_id_empleado', NEW.EMPLEADO_ID_EMPLEADO, 'old_mesa_id_mesa', OLD.MESA_ID_MESA, 'new_mesa_id_mesa', NEW.MESA_ID_MESA, 'old_cliente_id_cliente', OLD.CLIENTE_ID_CLIENTE, 'new_cliente_id_cliente', NEW.CLIENTE_ID_CLIENTE, 'old_estado_orden', OLD.ESTADO_ORDEN, 'new_estado_orden', NEW.ESTADO_ORDEN, 'old_fecha_orden', OLD.FECHA_ORDEN, 'new_fecha_orden', NEW.FECHA_ORDEN, 'old_total_pagar', OLD.TOTAL_PAGAR, 'new_total_pagar', NEW.TOTAL_PAGAR));
    END;
    


    CREATE OR REPLACE TRIGGER audit_orden_after_delete
    AFTER DELETE ON orden
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('orden', USER(), 'DELETE', JSON_OBJECT('old_id_orden', OLD.ID_ORDEN, 'old_empleado_id_empleado', OLD.EMPLEADO_ID_EMPLEADO, 'old_mesa_id_mesa', OLD.MESA_ID_MESA, 'old_cliente_id_cliente', OLD.CLIENTE_ID_CLIENTE, 'old_estado_orden', OLD.ESTADO_ORDEN, 'old_fecha_orden', OLD.FECHA_ORDEN, 'old_total_pagar', OLD.TOTAL_PAGAR));
    END;
    


    CREATE OR REPLACE TRIGGER audit_pago_after_insert
    AFTER INSERT ON pago
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('pago', USER(), 'INSERT', JSON_OBJECT('new_id_pago', NEW.ID_PAGO, 'new_cliente_id_cliente', NEW.CLIENTE_ID_CLIENTE, 'new_metodo_pago', NEW.METODO_PAGO, 'new_fecha_pago', NEW.FECHA_PAGO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_pago_after_update
    AFTER UPDATE ON pago
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('pago', USER(), 'UPDATE', JSON_OBJECT('old_id_pago', OLD.ID_PAGO, 'new_id_pago', NEW.ID_PAGO, 'old_cliente_id_cliente', OLD.CLIENTE_ID_CLIENTE, 'new_cliente_id_cliente', NEW.CLIENTE_ID_CLIENTE, 'old_metodo_pago', OLD.METODO_PAGO, 'new_metodo_pago', NEW.METODO_PAGO, 'old_fecha_pago', OLD.FECHA_PAGO, 'new_fecha_pago', NEW.FECHA_PAGO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_pago_after_delete
    AFTER DELETE ON pago
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('pago', USER(), 'DELETE', JSON_OBJECT('old_id_pago', OLD.ID_PAGO, 'old_cliente_id_cliente', OLD.CLIENTE_ID_CLIENTE, 'old_metodo_pago', OLD.METODO_PAGO, 'old_fecha_pago', OLD.FECHA_PAGO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_after_insert
    AFTER INSERT ON plato
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato', USER(), 'INSERT', JSON_OBJECT('new_id_plato', NEW.ID_PLATO, 'new_categoria_id_categoria_plato', NEW.CATEGORIA_ID_CATEGORIA_PLATO, 'new_nombre_plato', NEW.NOMBRE_PLATO, 'new_descripcion', NEW.DESCRIPCION, 'new_precio', NEW.PRECIO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_after_update
    AFTER UPDATE ON plato
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato', USER(), 'UPDATE', JSON_OBJECT('old_id_plato', OLD.ID_PLATO, 'new_id_plato', NEW.ID_PLATO, 'old_categoria_id_categoria_plato', OLD.CATEGORIA_ID_CATEGORIA_PLATO, 'new_categoria_id_categoria_plato', NEW.CATEGORIA_ID_CATEGORIA_PLATO, 'old_nombre_plato', OLD.NOMBRE_PLATO, 'new_nombre_plato', NEW.NOMBRE_PLATO, 'old_descripcion', OLD.DESCRIPCION, 'new_descripcion', NEW.DESCRIPCION, 'old_precio', OLD.PRECIO, 'new_precio', NEW.PRECIO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_after_delete
    AFTER DELETE ON plato
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato', USER(), 'DELETE', JSON_OBJECT('old_id_plato', OLD.ID_PLATO, 'old_categoria_id_categoria_plato', OLD.CATEGORIA_ID_CATEGORIA_PLATO, 'old_nombre_plato', OLD.NOMBRE_PLATO, 'old_descripcion', OLD.DESCRIPCION, 'old_precio', OLD.PRECIO));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_ingredientes_after_insert
    AFTER INSERT ON plato_ingredientes
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato_ingredientes', USER(), 'INSERT', JSON_OBJECT('new_plato_id_plato', NEW.PLATO_ID_PLATO, 'new_ingredientes_id_ingredientes', NEW.INGREDIENTES_ID_INGREDIENTES, 'new_cantidad', NEW.CANTIDAD));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_ingredientes_after_update
    AFTER UPDATE ON plato_ingredientes
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato_ingredientes', USER(), 'UPDATE', JSON_OBJECT('old_plato_id_plato', OLD.PLATO_ID_PLATO, 'new_plato_id_plato', NEW.PLATO_ID_PLATO, 'old_ingredientes_id_ingredientes', OLD.INGREDIENTES_ID_INGREDIENTES, 'new_ingredientes_id_ingredientes', NEW.INGREDIENTES_ID_INGREDIENTES, 'old_cantidad', OLD.CANTIDAD, 'new_cantidad', NEW.CANTIDAD));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_ingredientes_after_delete
    AFTER DELETE ON plato_ingredientes
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato_ingredientes', USER(), 'DELETE', JSON_OBJECT('old_plato_id_plato', OLD.PLATO_ID_PLATO, 'old_ingredientes_id_ingredientes', OLD.INGREDIENTES_ID_INGREDIENTES, 'old_cantidad', OLD.CANTIDAD));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_orden_after_insert
    AFTER INSERT ON plato_orden
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato_orden', USER(), 'INSERT', JSON_OBJECT('new_plato_id_plato', NEW.PLATO_ID_PLATO, 'new_orden_id_orden', NEW.ORDEN_ID_ORDEN, 'new_cantidad', NEW.CANTIDAD));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_orden_after_update
    AFTER UPDATE ON plato_orden
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato_orden', USER(), 'UPDATE', JSON_OBJECT('old_plato_id_plato', OLD.PLATO_ID_PLATO, 'new_plato_id_plato', NEW.PLATO_ID_PLATO, 'old_orden_id_orden', OLD.ORDEN_ID_ORDEN, 'new_orden_id_orden', NEW.ORDEN_ID_ORDEN, 'old_cantidad', OLD.CANTIDAD, 'new_cantidad', NEW.CANTIDAD));
    END;
    


    CREATE OR REPLACE TRIGGER audit_plato_orden_after_delete
    AFTER DELETE ON plato_orden
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('plato_orden', USER(), 'DELETE', JSON_OBJECT('old_plato_id_plato', OLD.PLATO_ID_PLATO, 'old_orden_id_orden', OLD.ORDEN_ID_ORDEN, 'old_cantidad', OLD.CANTIDAD));
    END;
    


    CREATE OR REPLACE TRIGGER audit_proveedor_after_insert
    AFTER INSERT ON proveedor
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('proveedor', USER(), 'INSERT', JSON_OBJECT('new_id_proveedor', NEW.ID_PROVEEDOR, 'new_compra_id_compra', NEW.COMPRA_ID_COMPRA, 'new_nombre', NEW.NOMBRE, 'new_telefono', NEW.TELEFONO, 'new_direccion', NEW.DIRECCION));
    END;
    


    CREATE OR REPLACE TRIGGER audit_proveedor_after_update
    AFTER UPDATE ON proveedor
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('proveedor', USER(), 'UPDATE', JSON_OBJECT('old_id_proveedor', OLD.ID_PROVEEDOR, 'new_id_proveedor', NEW.ID_PROVEEDOR, 'old_compra_id_compra', OLD.COMPRA_ID_COMPRA, 'new_compra_id_compra', NEW.COMPRA_ID_COMPRA, 'old_nombre', OLD.NOMBRE, 'new_nombre', NEW.NOMBRE, 'old_telefono', OLD.TELEFONO, 'new_telefono', NEW.TELEFONO, 'old_direccion', OLD.DIRECCION, 'new_direccion', NEW.DIRECCION));
    END;
    


    CREATE OR REPLACE TRIGGER audit_proveedor_after_delete
    AFTER DELETE ON proveedor
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('proveedor', USER(), 'DELETE', JSON_OBJECT('old_id_proveedor', OLD.ID_PROVEEDOR, 'old_compra_id_compra', OLD.COMPRA_ID_COMPRA, 'old_nombre', OLD.NOMBRE, 'old_telefono', OLD.TELEFONO, 'old_direccion', OLD.DIRECCION));
    END;
    


    CREATE OR REPLACE TRIGGER audit_queja_after_insert
    AFTER INSERT ON queja
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('queja', USER(), 'INSERT', JSON_OBJECT('new_id_queja', NEW.ID_QUEJA, 'new_fecha', NEW.FECHA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_queja_after_update
    AFTER UPDATE ON queja
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('queja', USER(), 'UPDATE', JSON_OBJECT('old_id_queja', OLD.ID_QUEJA, 'new_id_queja', NEW.ID_QUEJA, 'old_fecha', OLD.FECHA, 'new_fecha', NEW.FECHA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_queja_after_delete
    AFTER DELETE ON queja
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('queja', USER(), 'DELETE', JSON_OBJECT('old_id_queja', OLD.ID_QUEJA, 'old_fecha', OLD.FECHA));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservacion_after_insert
    AFTER INSERT ON reservacion
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservacion', USER(), 'INSERT', JSON_OBJECT('new_id_reservacion', NEW.ID_RESERVACION, 'new_mesa_id_mesa', NEW.MESA_ID_MESA, 'new_cliente_id_cliente', NEW.CLIENTE_ID_CLIENTE, 'new_comensales', NEW.COMENSALES, 'new_fecha_reservacion', NEW.FECHA_RESERVACION));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservacion_after_update
    AFTER UPDATE ON reservacion
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservacion', USER(), 'UPDATE', JSON_OBJECT('old_id_reservacion', OLD.ID_RESERVACION, 'new_id_reservacion', NEW.ID_RESERVACION, 'old_mesa_id_mesa', OLD.MESA_ID_MESA, 'new_mesa_id_mesa', NEW.MESA_ID_MESA, 'old_cliente_id_cliente', OLD.CLIENTE_ID_CLIENTE, 'new_cliente_id_cliente', NEW.CLIENTE_ID_CLIENTE, 'old_comensales', OLD.COMENSALES, 'new_comensales', NEW.COMENSALES, 'old_fecha_reservacion', OLD.FECHA_RESERVACION, 'new_fecha_reservacion', NEW.FECHA_RESERVACION));
    END;
    


    CREATE OR REPLACE TRIGGER audit_reservacion_after_delete
    AFTER DELETE ON reservacion
    FOR EACH ROW
    BEGIN
        INSERT INTO auditoria (nombre_tabla, usuario_db, accion, descripcion_cambios)
        VALUES ('reservacion', USER(), 'DELETE', JSON_OBJECT('old_id_reservacion', OLD.ID_RESERVACION, 'old_mesa_id_mesa', OLD.MESA_ID_MESA, 'old_cliente_id_cliente', OLD.CLIENTE_ID_CLIENTE, 'old_comensales', OLD.COMENSALES, 'old_fecha_reservacion', OLD.FECHA_RESERVACION));
    END;
    

