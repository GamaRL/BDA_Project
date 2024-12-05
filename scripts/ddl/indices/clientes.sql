-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     índices para el módulo de clientes

DROP INDEX IF EXISTS cliente_fecha_registro_ix;
DROP INDEX IF EXISTS cliente_username_iuk;
DROP INDEX IF EXISTS cliente_email_iuk;
DROP INDEX IF EXISTS cliente_email_dominio_ix;
DROP INDEX IF EXISTS cliente_telefono_ix;
DROP INDEX IF EXISTS empresa_nombre_iuk;
DROP INDEX IF EXISTS persona_fecha_nacimiento_ix;
DROP INDEX IF EXISTS tarjeta_cliente_anio_expiracion_ix;
DROP INDEX IF EXISTS tarjeta_cliente_mes_expiracion_ix;
DROP INDEX IF EXISTS tarjeta_cliente_banco_ix;

--
-- Índices: cliente
--
CREATE INDEX cliente_fecha_registro_ix
    ON cliente(TO_CHAR(fecha_registro, 'mm/yyyy'))
    TABLESPACE clientes_indexes_tbs;

CREATE UNIQUE INDEX cliente_username_iuk
    ON cliente(username)
    TABLESPACE clientes_indexes_tbs;

CREATE UNIQUE INDEX cliente_email_iuk
    On cliente(email)
    TABLESPACE clientes_indexes_tbs;

CREATE INDEX cliente_email_ix
    ON cliente(SUBSTR(email, INSTR(email, '@') + 1))
    TABLESPACE clientes_indexes_tbs;

CREATE INDEX cliente_telefono_ix
    ON cliente(SUBSTR(telefono, 1, 2))
    TABLESPACE clientes_indexes_tbs;

--
-- Índices: empresa
--
CREATE UNIQUE INDEX empresa_nombre_iuk
    ON empresa(nombre)
    TABLESPACE clientes_indexes_tbs;

--
-- Índices: persona
--
CREATE INDEX persona_fecha_nacimiento_ix
    ON persona(TO_CHAR(fecha_nacimiento, 'mm/yyyy'))
    TABLESPACE clientes_indexes_tbs;

--
-- Índices: tarjeta_cliente
--
CREATE INDEX tarjeta_cliente_anio_expiracion_ix
    ON tarjeta_cliente(anio_expiracion)
    TABLESPACE clientes_indexes_tbs;

CREATE INDEX tarjeta_cliente_mes_expiracion_ix
    ON tarjeta_cliente(mes_expiracion)
    TABLESPACE clientes_indexes_tbs;
