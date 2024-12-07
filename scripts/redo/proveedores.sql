
-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          5 de diciembre de 2024
-- @Descripcion:    Pobla las tablas del módulo proveedores


CREATE OR REPLACE PROCEDURE insertar_modulo_proveedores(
    p_cantidad IN NUMBER
    )
IS
    l_email VARCHAR2(50);
    l_proveedor_id NUMBER;
    l_servicio_proveedor_id NUMBER;
BEGIN
    FOR i IN 1..p_cantidad LOOP

        SELECT proveedor_id_seq.NEXTVAL INTO l_proveedor_id FROM dual;

        -- Generar correo válido
        l_email := 'email' || l_proveedor_id || '@example.com';

        -- Insertar en la tabla "proveedor"
        INSERT INTO proveedor(
            proveedor_id, nombre, apellido_paterno, apellido_materno, 
            foto, fecha_nacimiento, direccion, email, telefono_casa, 
            telefono_movil, identificacion, comprobante_domicilio, 
            entidad_nacimiento_id, nivel_escolaridad_id
        )
        VALUES(
            l_proveedor_id, 'Nombre_' || l_proveedor_id, 
            'ApellidoP_' || l_proveedor_id, 
            'ApellidoM_' || l_proveedor_id,
            EMPTY_BLOB(), SYSDATE, 
            'Direccion_' || l_proveedor_id, l_email,
            LPAD(l_proveedor_id, 12, '0'), LPAD(l_proveedor_id * 2, 12, '0'),
            EMPTY_BLOB(), EMPTY_BLOB(),
            MOD(l_proveedor_id, 32) + 1, MOD(l_proveedor_id, 6) + 1
        );

        -- Insertar en la tabla "cuenta_bancaria" (una cuenta por proveedor)
        INSERT INTO cuenta_bancaria (proveedor_id, clabe, banco)
        VALUES (l_proveedor_id, LPAD(l_proveedor_id * 12345, 18, '0'), 'Banco_' || MOD(l_proveedor_id, 10));

        -- Insertar servicios y comprobantes (1 o 2 servicios por proveedor)
        FOR j IN 1..CASE WHEN MOD(l_proveedor_id, 2) = 0 THEN 2 ELSE 1 END LOOP
            -- Determinar el rango de tipo_servicio_id
            SELECT servicio_proveedor_id_seq.NEXTVAL INTO l_servicio_proveedor_id FROM dual;
            INSERT INTO servicio_proveedor (
                servicio_proveedor_id, anios_experiencia, proveedor_id, tipo_servicio_id
            ) VALUES (
                l_servicio_proveedor_id, MOD(l_proveedor_id, 10) + 1, 
                l_proveedor_id, 
                CASE WHEN j = 1 THEN MOD(l_proveedor_id, 25) + 1 
                    ELSE MOD(l_proveedor_id, 25) + 26 END
            );

            -- Insertar 3 comprobantes por cada servicio
            FOR k IN 1..3 LOOP
                INSERT INTO comprobante_experiencia (
                    comprobante_domicilio_id, documento, servicio_proveedor_id
                ) VALUES (
                    comprobante_experiencia_id_seq.NEXTVAL, EMPTY_BLOB(), l_servicio_proveedor_id
                );
            END LOOP;
        END LOOP;
    END LOOP;

    COMMIT;
END;
/
