-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          5 de diciembre de 2024
-- @Descripcion:    Pobla las tablas del módulo servicios

CREATE OR REPLACE PROCEDURE insertar_modulo_servicios(
    N IN NUMBER
    )
IS
    v_servicio_contratacion_id NUMBER;
    v_num_multimedia NUMBER;
    v_num_pagos NUMBER;
    v_historico_count NUMBER;
BEGIN
    -- Inserción para la tabla "servicio_contratacion" y relacionadas
    FOR i IN 1..N LOOP
        -- Generar el ID de servicio_contratacion usando la secuencia
        SELECT servicio_contratacion_id_seq.NEXTVAL INTO v_servicio_contratacion_id FROM DUAL;

        -- Insertar en "servicio_contratacion"
        INSERT INTO servicio_contratacion (
            servicio_contratacion_id, fecha_servicio, requerimientos_generales,
            documento_descripcion, servicio_proveedor_id_fk, tarjeta_cliente_id_fk,
            status_servicio_contratacion_id
        ) VALUES (
            v_servicio_contratacion_id, SYSDATE, 
            'Requerimientos generales del servicio ' || v_servicio_contratacion_id,
            EMPTY_BLOB(), 
            MOD(v_servicio_contratacion_id, 50) + 1, -- Simulando proveedores
            MOD(v_servicio_contratacion_id, 100) + 1, -- Simulando tarjetas de clientes
            MOD(v_servicio_contratacion_id, 7) + 1 -- Ciclando entre los 7 status
        );

        -- Insertar en "servicio_aceptacion_oferta"
        INSERT INTO servicio_aceptacion_oferta (
            servicio_contratacion_id, precio, descripcion_oferta, 
            numero_mensualidades, documento_oferta
        ) VALUES (
            v_servicio_contratacion_id, 
            ROUND(DBMS_RANDOM.VALUE(5000, 20000), 2), 
            'Descripción de oferta para el servicio ' || v_servicio_contratacion_id, 
            CASE WHEN MOD(v_servicio_contratacion_id, 2) = 0 THEN MOD(v_servicio_contratacion_id, 12) ELSE NULL END,
            EMPTY_BLOB()
        );

        -- Insertar en "servicio_calificacion"
        INSERT INTO servicio_calificacion (
            servicio_contratacion_id, comentario, calificacion
        ) VALUES (
            v_servicio_contratacion_id, 
            'Comentario de calificación para el servicio ' || v_servicio_contratacion_id, 
            MOD(v_servicio_contratacion_id, 5) + 1
        );

        -- Insertar en "deposito_cuenta_proveedor"
        INSERT INTO deposito_cuenta_proveedor (
            deposito_cuenta_proveedor_id, importe, fecha_deposito, 
            comprobante_deposito, servicio_contratacion_id
        ) VALUES (
            v_servicio_contratacion_id,
            ROUND(DBMS_RANDOM.VALUE(1000, 5000), 2),
            SYSDATE,
            EMPTY_BLOB(),
            v_servicio_contratacion_id
        );

        -- Insertar múltiples pagos en "pago_servicio"
        v_num_pagos := TRUNC(DBMS_RANDOM.VALUE(1, 6)); -- Número de pagos (1 a 5)
        FOR j IN 1..v_num_pagos LOOP
            INSERT INTO pago_servicio (
                servicio_contratacion_id, numero_pago, fecha_cargo, 
                importe, comision
            ) VALUES (
                v_servicio_contratacion_id, 
                j, 
                SYSDATE, 
                ROUND(DBMS_RANDOM.VALUE(500, 3000), 2), 
                ROUND(DBMS_RANDOM.VALUE(50, 200), 2)
            );
        END LOOP;

        -- Insertar múltiples archivos multimedia en "multimedia_promocion"
        v_num_multimedia := TRUNC(DBMS_RANDOM.VALUE(1, 6)); -- Número de multimedia (1 a 5)
        FOR k IN 1..v_num_multimedia LOOP
            INSERT INTO multimedia_promocion (
                servicio_contratacion_id, numero_multimedia, 
                archivo_multimedia, formato_multimedia, descripcion
            ) VALUES (
                v_servicio_contratacion_id, 
                k, 
                EMPTY_BLOB(),
                CASE MOD(k, 3)
                    WHEN 0 THEN 'JPEG'
                    WHEN 1 THEN 'PNG'
                    WHEN 2 THEN 'MP4'
                END, 
                'Archivo multimedia ' || v_servicio_contratacion_id || '-' || k
            );
        END LOOP;

        -- Insertar múltiples registros en "historico_status_servicio"
        v_historico_count := TRUNC(DBMS_RANDOM.VALUE(2, 7)); -- Número de registros (2 a 6)
        FOR l IN 1..v_historico_count LOOP
            INSERT INTO historico_status_servicio (
                historico_status_servicio_id, fecha_status, 
                servicio_contratacion_id, status_servicio_contratacion_id
            ) VALUES (
                historico_status_servicio_id_seq.NEXTVAL, 
                SYSDATE, 
                v_servicio_contratacion_id, 
                MOD(v_servicio_contratacion_id + l, 7) + 1
            );
        END LOOP;
    END LOOP;

    -- Confirmar los cambios
    COMMIT;
END;
/