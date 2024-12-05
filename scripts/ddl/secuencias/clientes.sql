-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Secuencias para el módulo de clientes

DROP SEQUENCE IF EXISTS cliente_seq;
DROP SEQUENCE IF EXISTS tarjeta_cliente_seq;


CREATE SEQUENCE cliente_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE SEQUENCE tarjeta_cliente_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;