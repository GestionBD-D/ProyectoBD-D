
        BEGIN
            EXECUTE IMMEDIATE 'DROP TRIGGER audit_CLIENTE_trg';
        EXCEPTION
            WHEN OTHERS THEN
                IF SQLCODE != -4080 THEN
                    RAISE;
                END IF;
        END;
        

    CREATE OR REPLACE TRIGGER audit_CLIENTE_trg
    AFTER INSERT OR UPDATE OR DELETE ON CLIENTE
    FOR EACH ROW
    BEGIN
        IF INSERTING THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('CLIENTE', USER, 'INSERT', :NEW.ID_CLIENTE || ',' || :NEW.NOMBRE || ',' || :NEW.APELLIDO || ',' || :NEW.DIRECCION || ',' || :NEW.TELEFONO || ',' || :NEW.CORREO);
        ELSIF UPDATING THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('CLIENTE', USER, 'UPDATE', :NEW.ID_CLIENTE || ',' || :NEW.NOMBRE || ',' || :NEW.APELLIDO || ',' || :NEW.DIRECCION || ',' || :NEW.TELEFONO || ',' || :NEW.CORREO);
        ELSIF DELETING THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('CLIENTE', USER, 'DELETE', :OLD.ID_CLIENTE || ',' || :OLD.NOMBRE || ',' || :OLD.APELLIDO || ',' || :OLD.DIRECCION || ',' || :OLD.TELEFONO || ',' || :OLD.CORREO);
        END IF;
    END;
    