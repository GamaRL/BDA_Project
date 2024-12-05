CONNECT hs_proveedores_admin/hs@proveedor;

-- TRUNCATE: Limpiar tablas para evitar conflictos con claves foráneas
-- TRUNCATE TABLE comprobante_experiencia;
-- TRUNCATE TABLE servicio_proveedor;
-- TRUNCATE TABLE tipo_servicio;
-- TRUNCATE TABLE cuenta_bancaria;
-- TRUNCATE TABLE proveedor;
-- TRUNCATE TABLE nivel_escolaridad;
-- TRUNCATE TABLE entidad;

-- Inserción para la tabla "entidad"
BEGIN
    FOR i IN 1..32 LOOP
        INSERT INTO entidad (entidad_id, clave_entidad, nombre_entidad)
        VALUES (i, LPAD(i, 2, '0'), 'Entidad_' || TO_CHAR(i));
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "nivel_escolaridad"
BEGIN
    FOR i IN 1..6 LOOP
        INSERT INTO nivel_escolaridad (nivel_escolaridad_id, grado_escolaridad, descripcion)
        VALUES (i, i * 10, 'Nivel ' || TO_CHAR(i));
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "proveedor" con validación de correo
DECLARE
    l_email VARCHAR2(50);
    l_valid BOOLEAN;
BEGIN
    FOR i IN 1..1000 LOOP
        l_email := 'email' || i || '@example.com';
        -- Validar el formato del correo
        IF REGEXP_LIKE(l_email, '^[a-zA-Z0-9.]+@[a-zA-Z0-9.-]+\.(com|net|org|edu|gov|mil)$') THEN
            INSERT INTO proveedor (
                proveedor_id, nombre, apellido_paterno, apellido_materno, 
                foto, fecha_nacimiento, direccion, email, telefono_casa, 
                telefono_movil, identificacion, comprobante_domicilio, 
                entidad_nacimiento_id, nivel_escolaridad_id
            ) VALUES (
                i, 'Nombre_' || i, 'ApellidoP_' || i, 'ApellidoM_' || i,
                EMPTY_BLOB(), SYSDATE - (i * 365), 
                'Direccion_' || i, l_email,
                LPAD(i, 12, '0'), LPAD(i * 2, 12, '0'),
                EMPTY_BLOB(), EMPTY_BLOB(),
                MOD(i, 32) + 1, MOD(i, 6) + 1
            );
        ELSE
            DBMS_OUTPUT.PUT_LINE('Correo inválido: ' || l_email);
        END IF;
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "cuenta_bancaria"
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO cuenta_bancaria (proveedor_id, clabe, banco)
        VALUES (i, LPAD(i * 12345, 18, '0'), 'Banco_' || MOD(i, 10));
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "tipo_servicio"
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO tipo_servicio (tipo_servicio_id, nombre_servicio, descripcion)
        VALUES (i, 'Servicio_' || i, 'Descripción del servicio ' || i);
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "servicio_proveedor"
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO servicio_proveedor (
            servicio_proveedor_id, anios_experiencia, proveedor_id, tipo_servicio_id
        ) VALUES (
            i, MOD(i, 10) + 1, MOD(i, 1000) + 1, MOD(i, 50) + 1
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "comprobante_experiencia"
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO comprobante_experiencia (
            comprobante_domicilio_id, documento, servicio_proveedor_id
        ) VALUES (
            i, EMPTY_BLOB(), MOD(i, 1000) + 1
        );
    END LOOP;
    COMMIT;
END;
/
