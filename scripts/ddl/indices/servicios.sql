-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          4 de diciembre de 2024
-- @Descripcion     índices para el módulo de servicios

DROP INDEX IF EXISTS status_servicio_contratacion_nombre_status_iuk;
DROP INDEX IF EXISTS servicio_contratacion_fecha_servicio_ix;
DROP INDEX IF EXISTS servicio_contratacion_servicio_proveedor_id_fk_ix;
DROP INDEX IF EXISTS servicio_contratacion_tarjeta_cliente_id_fk_ix;
DROP INDEX IF EXISTS servicio_contratacion_ix;
DROP INDEX IF EXISTS servicio_contratacion_status_servicio_contratacion_id_ix;
DROP INDEX IF EXISTS historico_status_servicio_fecha_status_ix;
DROP INDEX IF EXISTS historico_status_servicio_servicio_contratacion_id_ix;
DROP INDEX IF EXISTS historico_status_servicio_status_servicio_contratacion_id_ix;
DROP INDEX IF EXISTS deposito_cuenta_proveedor_fecha_deposito_ix;
DROP INDEX IF EXISTS deposito_cuenta_proveedor_servicio_contratacion_id_ix;
DROP INDEX IF EXISTS pago_servicio_fecha_cargo_ix;
DROP INDEX IF EXISTS multimedia_promocion_formato_multimedia_ix;

--
-- Índices: status_servicio_contratacion
--


--
-- Índices: servicio_contratacion
--
CREATE INDEX servicio_contratacion_fecha_servicio_ix
    ON servicio_contratacion(TO_CHAR(fecha_servicio, 'dd/mm/yyyy'))
    TABLESPACE servicios_indexes_tbs;

CREATE INDEX servicio_contratacion_servicio_proveedor_id_fk_ix
    ON servicio_contratacion(servicio_proveedor_id_fk)
    TABLESPACE servicios_indexes_tbs;

CREATE INDEX servicio_contratacion_tarjeta_cliente_id_fk_ix
    ON servicio_contratacion(tarjeta_cliente_id_fk)
    TABLESPACE servicios_indexes_tbs;

CREATE INDEX servicio_contratacion_status_servicio_contratacion_id_ix
    ON servicio_contratacion(status_servicio_contratacion_id)
    TABLESPACE servicios_indexes_tbs;

--
-- Índices: historico_status_servicio
--
CREATE INDEX historico_status_servicio_fecha_status_ix
    ON historico_status_servicio(TO_CHAR(fecha_status, 'dd/mm/yyyy'))
    TABLESPACE servicios_indexes_tbs;

CREATE INDEX historico_status_servicio_servicio_contratacion_id_ix
    ON historico_status_servicio(servicio_contratacion_id)
    TABLESPACE servicios_indexes_tbs;

CREATE INDEX historico_status_servicio_status_servicio_contratacion_id_ix
    ON historico_status_servicio(status_servicio_contratacion_id)
    TABLESPACE servicios_indexes_tbs;

--
-- Índices: deposito_cuenta_proveedor
--
CREATE INDEX deposito_cuenta_proveedor_fecha_deposito_ix
    ON deposito_cuenta_proveedor(TO_CHAR(fecha_deposito, 'dd/mm/yyyy'))
    TABLESPACE servicios_indexes_tbs;

CREATE INDEX deposito_cuenta_proveedor_servicio_contratacion_id_ix
    ON deposito_cuenta_proveedor(servicio_contratacion_id)
    TABLESPACE servicios_indexes_tbs;

--
-- Índices: pago_servicio
--
CREATE INDEX pago_servicio_fecha_cargo_ix
    ON pago_servicio(fecha_cargo)
    TABLESPACE servicios_indexes_tbs;

--
-- Índices: servicio_aceptacion_oferta
--


--
-- Índices: servicio_calificacion
--


--
-- Índices: multimedia_promocion
--
CREATE INDEX multimedia_promocion_formato_multimedia_ix
    ON multimedia_promocion(formato_multimedia)
    TABLESPACE servicios_indexes_tbs;