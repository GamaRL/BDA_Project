-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          4 de diciembre de 2024
-- @Descripcion     Secuencias para el módulo de proveedores

DROP SEQUENCE IF EXISTS entidad_seq;
DROP SEQUENCE IF EXISTS nivel_escolaridad_seq;
DROP SEQUENCE IF EXISTS comprobante_experiencia_seq;
DROP SEQUENCE IF EXISTS proveedor_seq;
DROP SEQUENCE IF EXISTS servicio_proveedor_seq;
DROP SEQUENCE IF EXISTS tipo_servicio_seq;

CREATE SEQUENCE entidad_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE nivel_escolaridad_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE comprobante_experiencia_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE proveedor_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE servicio_proveedor_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE tipo_servicio_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;