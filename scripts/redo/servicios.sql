CONNECT hs_servicios_admin/hs@servicios;

-- TRUNCATE: Limpiar tablas para evitar conflictos con claves foráneas
TRUNCATE TABLE multimedia_promocion;
TRUNCATE TABLE servicio_calificacion;
TRUNCATE TABLE servicio_aceptacion_oferta;
TRUNCATE TABLE pago_servicio;
TRUNCATE TABLE deposito_cuenta_proveedor;
TRUNCATE TABLE historico_status_servicio;
TRUNCATE TABLE servicio_contratacion;
TRUNCATE TABLE status_servicio_contratacion;

-- Inserción para la tabla "status_servicio_contratacion"
BEGIN
    FOR i IN 1..7 LOOP
        INSERT INTO status_servicio_contratacion (
            status_servicio_contratacion_id, nombre_status, descripcion
        ) VALUES (
            i,
            CASE i
                WHEN 1 THEN 'REGISTRADO'
                WHEN 2 THEN 'ACEPTADO'
                WHEN 3 THEN 'POR PAGAR'
                WHEN 4 THEN 'PAGADO'
                WHEN 5 THEN 'EN EJECUCIÓN'
                WHEN 6 THEN 'FINALIZADO'
                WHEN 7 THEN 'RECHAZADO'
            END,
            'Descripción del status ' || i
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "servicio_contratacion"
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO servicio_contratacion (
            servicio_contratacion_id, fecha_servicio, requerimientos_generales,
            documento_descripcion, servicio_proveedor_id_fk, tarjeta_cliente_id_fk,
            status_servicio_contratacion_id
        ) VALUES (
            i, SYSDATE - i, 
            'Requerimientos generales del servicio ' || i,
            EMPTY_BLOB(), 
            MOD(i, 50) + 1, -- Simulando proveedores
            MOD(i, 100) + 1, -- Simulando tarjetas de clientes
            MOD(i, 7) + 1 -- Ciclando entre los 7 status
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "historico_status_servicio"
BEGIN
    FOR i IN 1..300 LOOP
        INSERT INTO historico_status_servicio (
            historico_status_servicio_id, fecha_status, 
            servicio_contratacion_id, status_servicio_contratacion_id
        ) VALUES (
            i, SYSDATE - i, 
            MOD(i, 100) + 1, -- Relación con servicio_contratacion
            MOD(i, 7) + 1 -- Relación con status_servicio_contratacion
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "deposito_cuenta_proveedor"
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO deposito_cuenta_proveedor (
            deposito_cuenta_proveedor_id, importe, fecha_deposito, 
            comprobante_deposito, servicio_contratacion_id
        ) VALUES (
            i, 
            ROUND(DBMS_RANDOM.VALUE(1000, 5000), 2),
            SYSDATE - i, 
            EMPTY_BLOB(), 
            MOD(i, 100) + 1 -- Relación con servicio_contratacion
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "pago_servicio"
BEGIN
    FOR i IN 1..200 LOOP
        INSERT INTO pago_servicio (
            servicio_contratacion_id, numero_pago, fecha_cargo, 
            importe, comision
        ) VALUES (
            MOD(i, 100) + 1, 
            i, 
            SYSDATE - i, 
            ROUND(DBMS_RANDOM.VALUE(500, 3000), 2), 
            ROUND(DBMS_RANDOM.VALUE(50, 200), 2)
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "servicio_aceptacion_oferta"
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO servicio_aceptacion_oferta (
            servicio_contratacion_id, precio, descripcion_oferta, 
            numero_mensualidades, documento_oferta
        ) VALUES (
            i, 
            ROUND(DBMS_RANDOM.VALUE(5000, 20000), 2), 
            'Descripción de oferta para el servicio ' || i, 
            CASE WHEN MOD(i, 2) = 0 THEN MOD(i, 12) ELSE NULL END,
            EMPTY_BLOB()
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "servicio_calificacion"
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO servicio_calificacion (
            servicio_contratacion_id, comentario, calificacion
        ) VALUES (
            i, 
            'Comentario de calificación para el servicio ' || i, 
            MOD(i, 5) + 1
        );
    END LOOP;
    COMMIT;
END;
/

-- Inserción para la tabla "multimedia_promocion"
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO multimedia_promocion (
            servicio_contratacion_id, numero_multinedia, 
            archivo_multimedia, formato_multimedia, descripcion
        ) VALUES (
            MOD(i, 100) + 1, 
            MOD(i, 10) + 1, 
            EMPTY_BLOB(), 
            CASE MOD(i, 3)
                WHEN 0 THEN 'JPEG'
                WHEN 1 THEN 'PNG'
                WHEN 2 THEN 'MP4'
            END, 
            'Archivo multimedia ' || i
        );
    END LOOP;
    COMMIT;
END;
/
