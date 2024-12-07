-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          5 de diciembre de 2024
-- @Descripcion:    Pobla las tablas del módulo clientes

CREATE OR REPLACE PROCEDURE insertar_modulo_clientes(
    p_num_clientes IN NUMBER
)
IS
    v_cliente_id    NUMBER;
    v_tarjeta_id    NUMBER;
BEGIN

    -- Cantidad de inserciones en "cliente"
    FOR i IN 1..p_num_clientes LOOP

        -- Siguiente número de la secuencia cliente_id_seq
        SELECT cliente_id_seq.NEXTVAL INTO v_cliente_id FROM dual;

        -- Inserción para la tabla "cliente"
        INSERT INTO cliente(
            cliente_id, fecha_registro, username, contrasena, 
            email, telefono, direccion, tipo
        )
        VALUES(
            v_cliente_id, SYSDATE, 
            'user' || v_cliente_id, 'pass_' || LPAD(v_cliente_id, 4, '0'),
            'email' || v_cliente_id || '@example.com', 
            LPAD(v_cliente_id * 12345, 12, '0'), 
            'Direccion_' || v_cliente_id, 
            CASE WHEN MOD(v_cliente_id, 2) = 0 THEN 'E' ELSE 'P' END
        );

        IF MOD(v_cliente_id, 2) = 0 THEN
            -- Inserción en "empresa" si el tipo es 'E'
            INSERT INTO empresa(
                cliente_id, nombre, descripcion, logotipo, numero_empleado
            )
            VALUES(
                v_cliente_id, 
                'Empresa_' || v_cliente_id, 
                'Descripción de la empresa ' || v_cliente_id,
                EMPTY_BLOB(), 
                MOD(v_cliente_id, 1000) + 1
            );

        ELSE
            -- Inserción en "persona" si el tipo es 'P'
            INSERT INTO persona(
                cliente_id, nombre, foto, curp, fecha_nacimiento
            )
            VALUES(
                v_cliente_id, 
                'Nombre Persona ' || v_cliente_id, 
                EMPTY_BLOB(), 
                LPAD(v_cliente_id * 987654321, 18, '0'), 
                SYSDATE
            );
        END IF;

        -- Cantidad de inserciones en "tarjeta_cliente" por cada "cliente"
        FOR j IN 1..MOD(v_cliente_id, 3) + 1 LOOP

            -- Siguiente número de la secuencia tarjeta_cliente_id_seq
            SELECT tarjeta_cliente_id_seq.NEXTVAL INTO v_tarjeta_id FROM dual;

            -- Inserción para "tarjeta_cliente"
            INSERT INTO tarjeta_cliente (
                tarjeta_cliente_id, numero_tarjeta, anio_expiracion, 
                mes_expiracion, numero_seguridad, banco, cliente_id
            ) VALUES (
                v_tarjeta_id, 
                LPAD(v_tarjeta_id * 54321, 16, '0'), 
                2024 + MOD(v_tarjeta_id, 5), 
                MOD(v_tarjeta_id, 12) + 1, 
                MOD(v_tarjeta_id, 1000), 
                'Banco_' || MOD(v_tarjeta_id, 10), 
                v_cliente_id
            );
        END LOOP;

    END LOOP;

    COMMIT;

END;
/