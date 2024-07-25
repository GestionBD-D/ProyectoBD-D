
    IF OBJECT_ID('CLIENTE_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER CLIENTE_audit_trigger;
    

    CREATE TRIGGER CLIENTE_audit_trigger
    ON CLIENTE
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CLIENTE', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CLIENTE', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CLIENTE', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('QUEJA_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER QUEJA_audit_trigger;
    

    CREATE TRIGGER QUEJA_audit_trigger
    ON QUEJA
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'QUEJA', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'QUEJA', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'QUEJA', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('PAGO_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER PAGO_audit_trigger;
    

    CREATE TRIGGER PAGO_audit_trigger
    ON PAGO
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PAGO', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PAGO', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PAGO', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('CATEGORIA_PLATO_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER CATEGORIA_PLATO_audit_trigger;
    

    CREATE TRIGGER CATEGORIA_PLATO_audit_trigger
    ON CATEGORIA_PLATO
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CATEGORIA_PLATO', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CATEGORIA_PLATO', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CATEGORIA_PLATO', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('PLATO_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER PLATO_audit_trigger;
    

    CREATE TRIGGER PLATO_audit_trigger
    ON PLATO
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('COMPRA_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER COMPRA_audit_trigger;
    

    CREATE TRIGGER COMPRA_audit_trigger
    ON COMPRA
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'COMPRA', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'COMPRA', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'COMPRA', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('PROVEEDOR_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER PROVEEDOR_audit_trigger;
    

    CREATE TRIGGER PROVEEDOR_audit_trigger
    ON PROVEEDOR
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PROVEEDOR', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PROVEEDOR', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PROVEEDOR', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('INGREDIENTES_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER INGREDIENTES_audit_trigger;
    

    CREATE TRIGGER INGREDIENTES_audit_trigger
    ON INGREDIENTES
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'INGREDIENTES', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'INGREDIENTES', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'INGREDIENTES', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('EMPLEADO_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER EMPLEADO_audit_trigger;
    

    CREATE TRIGGER EMPLEADO_audit_trigger
    ON EMPLEADO
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'EMPLEADO', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'EMPLEADO', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'EMPLEADO', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('MESA_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER MESA_audit_trigger;
    

    CREATE TRIGGER MESA_audit_trigger
    ON MESA
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'MESA', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'MESA', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'MESA', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('RESERVACION_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER RESERVACION_audit_trigger;
    

    CREATE TRIGGER RESERVACION_audit_trigger
    ON RESERVACION
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'RESERVACION', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'RESERVACION', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'RESERVACION', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('ORDEN_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER ORDEN_audit_trigger;
    

    CREATE TRIGGER ORDEN_audit_trigger
    ON ORDEN
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'ORDEN', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'ORDEN', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'ORDEN', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('FACTURA_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER FACTURA_audit_trigger;
    

    CREATE TRIGGER FACTURA_audit_trigger
    ON FACTURA
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'FACTURA', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'FACTURA', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'FACTURA', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('DETALLE_FACTURA_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER DETALLE_FACTURA_audit_trigger;
    

    CREATE TRIGGER DETALLE_FACTURA_audit_trigger
    ON DETALLE_FACTURA
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'DETALLE_FACTURA', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'DETALLE_FACTURA', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'DETALLE_FACTURA', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('CLIENTE_QUEJA_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER CLIENTE_QUEJA_audit_trigger;
    

    CREATE TRIGGER CLIENTE_QUEJA_audit_trigger
    ON CLIENTE_QUEJA
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CLIENTE_QUEJA', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CLIENTE_QUEJA', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'CLIENTE_QUEJA', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('PLATO_ORDEN_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER PLATO_ORDEN_audit_trigger;
    

    CREATE TRIGGER PLATO_ORDEN_audit_trigger
    ON PLATO_ORDEN
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO_ORDEN', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO_ORDEN', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO_ORDEN', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    

    IF OBJECT_ID('PLATO_INGREDIENTES_audit_trigger', 'TR') IS NOT NULL
    DROP TRIGGER PLATO_INGREDIENTES_audit_trigger;
    

    CREATE TRIGGER PLATO_INGREDIENTES_audit_trigger
    ON PLATO_INGREDIENTES
    AFTER INSERT, UPDATE, DELETE
    AS
    BEGIN
        IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Update
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO_INGREDIENTES', SYSTEM_USER, 'UPDATE', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM INSERTED)
        BEGIN
            -- Insert
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO_INGREDIENTES', SYSTEM_USER, 'INSERT', (SELECT * FROM INSERTED FOR JSON PATH);
        END
        ELSE IF EXISTS (SELECT * FROM DELETED)
        BEGIN
            -- Delete
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            SELECT 'PLATO_INGREDIENTES', SYSTEM_USER, 'DELETE', (SELECT * FROM DELETED FOR JSON PATH);
        END
    END;
    