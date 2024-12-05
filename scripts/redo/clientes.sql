CONNECT hs_clientes_admin/hs@cliente;

-- TRUNCATE: Limpiar tablas para evitar conflictos con claves foráneas
TRUNCATE TABLE tarjeta_cliente;
TRUNCATE TABLE persona;
TRUNCATE TABLE empresa;
TRUNCATE TABLE cliente;

-- Inserción para la tabla "cliente"
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO cliente (
            cliente_id, fecha_registro, username, contrasena, 
            email, telefono, direccion, tipo
        ) VALUES (
            i, SYSDATE - MOD(i, 365), 
            'user' || i, 'pass_' || LPAD(i, 4, '0'),
            'email' || i || '@example.com', 
            LPAD(i * 12345, 12, '0'), 
            'Direccion_' || i, 
            CASE WHEN MOD(i, 2) = 0 THEN 'E' ELSE 'P' END
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "empresa"
BEGIN
    FOR i IN 1..500 LOOP
        INSERT INTO empresa (
            cliente_id, nombre, descripcion, logotipo, numero_empleado
        ) VALUES (
            i * 2, 
            'Empresa_' || i, 
            'Descripción de la empresa ' || i,
            EMPTY_BLOB(), 
            MOD(i, 1000) + 1
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "persona"
BEGIN
    FOR i IN 1..500 LOOP
        INSERT INTO persona (
            cliente_id, nombre, foto, curp, fecha_nacimiento
        ) VALUES (
            i * 2 - 1, 
            'Nombre Persona ' || i, 
            EMPTY_BLOB(), 
            LPAD(i * 987654321, 18, '0'), 
            SYSDATE - (i * 1000)
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "tarjeta_cliente"
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO tarjeta_cliente (
            tarjeta_cliente_id, numero_tarjeta, anio_expiracion, 
            mes_expiracion, numero_seguridad, banco, cliente_id
        ) VALUES (
            i, 
            LPAD(i * 54321, 16, '0'), 
            2024 + MOD(i, 5), 
            MOD(i, 12) + 1, 
            MOD(i, 1000), 
            'Banco_' || MOD(i, 10), 
            MOD(i, 1000) + 1
        );
    END LOOP;
    COMMIT;
END;
/
