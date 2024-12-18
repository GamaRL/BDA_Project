-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          4 de diciembre de 2024
-- @Descripcion     Secuencias para el módulo de proveedores

DROP SEQUENCE IF EXISTS comprobante_experiencia_id_seq;
DROP SEQUENCE IF EXISTS proveedor_id_seq;
DROP SEQUENCE IF EXISTS servicio_proveedor_id_seq;

CREATE SEQUENCE comprobante_experiencia_id_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE servicio_proveedor_id_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;