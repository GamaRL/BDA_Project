-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          5 de diciembre de 2024
-- @Descripcion:    Pobla las tablas catálogo del módulo proveedores

TRUNCATE TABLE entidad;
TRUNCATE TABLE nivel_escolaridad;
TRUNCATE TABLE tipo_servicio;

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

-- Inserción para la tabla "tipo_servicio"
BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO tipo_servicio (tipo_servicio_id, nombre_servicio, descripcion)
        VALUES (i, 'Servicio_' || i, 'Descripción del servicio ' || i);
    END LOOP;
    COMMIT;
END;
/