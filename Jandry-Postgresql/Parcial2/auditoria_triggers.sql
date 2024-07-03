
    CREATE OR REPLACE FUNCTION audit_cliente() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('cliente', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('cliente', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('cliente', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS cliente_audit_trigger ON cliente;
    CREATE TRIGGER cliente_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON cliente
    FOR EACH ROW EXECUTE FUNCTION audit_cliente();
    
    CREATE OR REPLACE FUNCTION audit_pago() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('pago', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('pago', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('pago', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS pago_audit_trigger ON pago;
    CREATE TRIGGER pago_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON pago
    FOR EACH ROW EXECUTE FUNCTION audit_pago();
    
    CREATE OR REPLACE FUNCTION audit_categoria_plato() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('categoria_plato', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('categoria_plato', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('categoria_plato', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS categoria_plato_audit_trigger ON categoria_plato;
    CREATE TRIGGER categoria_plato_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON categoria_plato
    FOR EACH ROW EXECUTE FUNCTION audit_categoria_plato();
    
    CREATE OR REPLACE FUNCTION audit_plato() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS plato_audit_trigger ON plato;
    CREATE TRIGGER plato_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON plato
    FOR EACH ROW EXECUTE FUNCTION audit_plato();
    
    CREATE OR REPLACE FUNCTION audit_compra() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('compra', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('compra', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('compra', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS compra_audit_trigger ON compra;
    CREATE TRIGGER compra_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON compra
    FOR EACH ROW EXECUTE FUNCTION audit_compra();
    
    CREATE OR REPLACE FUNCTION audit_proveedor() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('proveedor', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('proveedor', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('proveedor', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS proveedor_audit_trigger ON proveedor;
    CREATE TRIGGER proveedor_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON proveedor
    FOR EACH ROW EXECUTE FUNCTION audit_proveedor();
    
    CREATE OR REPLACE FUNCTION audit_ingredientes() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('ingredientes', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('ingredientes', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('ingredientes', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS ingredientes_audit_trigger ON ingredientes;
    CREATE TRIGGER ingredientes_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON ingredientes
    FOR EACH ROW EXECUTE FUNCTION audit_ingredientes();
    
    CREATE OR REPLACE FUNCTION audit_empleado() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('empleado', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('empleado', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('empleado', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS empleado_audit_trigger ON empleado;
    CREATE TRIGGER empleado_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON empleado
    FOR EACH ROW EXECUTE FUNCTION audit_empleado();
    
    CREATE OR REPLACE FUNCTION audit_mesa() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('mesa', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('mesa', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('mesa', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS mesa_audit_trigger ON mesa;
    CREATE TRIGGER mesa_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON mesa
    FOR EACH ROW EXECUTE FUNCTION audit_mesa();
    
    CREATE OR REPLACE FUNCTION audit_reservacion() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('reservacion', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('reservacion', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('reservacion', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS reservacion_audit_trigger ON reservacion;
    CREATE TRIGGER reservacion_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON reservacion
    FOR EACH ROW EXECUTE FUNCTION audit_reservacion();
    
    CREATE OR REPLACE FUNCTION audit_orden() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('orden', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('orden', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('orden', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS orden_audit_trigger ON orden;
    CREATE TRIGGER orden_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON orden
    FOR EACH ROW EXECUTE FUNCTION audit_orden();
    
    CREATE OR REPLACE FUNCTION audit_factura() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('factura', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('factura', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('factura', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS factura_audit_trigger ON factura;
    CREATE TRIGGER factura_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON factura
    FOR EACH ROW EXECUTE FUNCTION audit_factura();
    
    CREATE OR REPLACE FUNCTION audit_detalle_factura() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('detalle_factura', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('detalle_factura', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('detalle_factura', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS detalle_factura_audit_trigger ON detalle_factura;
    CREATE TRIGGER detalle_factura_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON detalle_factura
    FOR EACH ROW EXECUTE FUNCTION audit_detalle_factura();
    
    CREATE OR REPLACE FUNCTION audit_cliente_queja() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('cliente_queja', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('cliente_queja', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('cliente_queja', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS cliente_queja_audit_trigger ON cliente_queja;
    CREATE TRIGGER cliente_queja_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON cliente_queja
    FOR EACH ROW EXECUTE FUNCTION audit_cliente_queja();
    
    CREATE OR REPLACE FUNCTION audit_queja() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('queja', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('queja', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('queja', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS queja_audit_trigger ON queja;
    CREATE TRIGGER queja_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON queja
    FOR EACH ROW EXECUTE FUNCTION audit_queja();
    
    CREATE OR REPLACE FUNCTION audit_plato_orden() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato_orden', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato_orden', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato_orden', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS plato_orden_audit_trigger ON plato_orden;
    CREATE TRIGGER plato_orden_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON plato_orden
    FOR EACH ROW EXECUTE FUNCTION audit_plato_orden();
    
    CREATE OR REPLACE FUNCTION audit_plato_ingredientes() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato_ingredientes', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato_ingredientes', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('plato_ingredientes', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS plato_ingredientes_audit_trigger ON plato_ingredientes;
    CREATE TRIGGER plato_ingredientes_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON plato_ingredientes
    FOR EACH ROW EXECUTE FUNCTION audit_plato_ingredientes();
    