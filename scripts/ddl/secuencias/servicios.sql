-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          4 de diciembre de 2024
-- @Descripcion     Secuencias para el módulo de servicios

DROP SEQUENCE IF EXISTS servicio_contratacion_id_seq;
DROP SEQUENCE IF EXISTS historico_status_servicio_id_seq;

CREATE SEQUENCE servicio_contratacion_id_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE historico_status_servicio_id_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;