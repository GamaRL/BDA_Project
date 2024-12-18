-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          5 de diciembre de 2024
-- @Descripcion:    Pobla las tablas catálogo del módulo servicios

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