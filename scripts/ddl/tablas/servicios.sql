-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     DDL para el módulo de servicios

DROP TABLE IF EXISTS multimedia_promocion;
DROP TABLE IF EXISTS servicio_calificacion;
DROP TABLE IF EXISTS servicio_aceptacion_oferta;
DROP TABLE IF EXISTS pago_servicio;
DROP TABLE IF EXISTS deposito_cuenta_proveedor;
DROP TABLE IF EXISTS historico_status_servicio;
DROP TABLE IF EXISTS servicio_contratacion;
DROP TABLE IF EXISTS status_servicio_contratacion;

--
-- Tabla: status_servicio_contratacion
--
CREATE TABLE status_servicio_contratacion(
    status_servicio_contratacion_id         NUMBER(1,0)         NOT NULL,
    nombre_status                           VARCHAR2(15)        NOT NULL,
    descripcion                             VARCHAR2(250)       NOT NULL,
    CONSTRAINT status_servicio_contratacion_pk
        PRIMARY KEY(status_servicio_contratacion_id)
        USING INDEX TABLESPACE servicios_indexes_tbs,
    CONSTRAINT status_servicio_contratacion_nombre_status_chk CHECK(
        nombre_status IN(
            'REGISTRADO',
            'ACEPTADO',
            'POR PAGAR',
            'PAGADO',
            'EN EJECUCIÓN',
            'FINALIZADO',
            'RECHAZADO'
        )
    )
)
PCTFREE 10
TABLESPACE servicios_data_tbs
;

--
-- Tabla: servicio_contratacion
--
CREATE TABLE servicio_contratacion(
    servicio_contratacion_id            NUMBER(10,0)                NOT NULL,
    fecha_servicio                      TIMESTAMP DEFAULT SYSDATE   NOT NULL,
    requerimientos_generales            VARCHAR2(1000)              NOT NULL,
    documento_descripcion               BLOB                        NOT NULL,
    servicio_proveedor_id_fk            NUMBER(10,0)                NOT NULL,
    tarjeta_cliente_id_fk               NUMBER(10,0)                NOT NULL,
    status_servicio_contratacion_id     NUMBER(1,0)                 NOT NULL,
    CONSTRAINT servicio_contratacion_pk
        PRIMARY KEY(servicio_contratacion_id)
        USING INDEX TABLESPACE servicios_indexes_tbs
)
PCTFREE 10
TABLESPACE servicios_contratacion_tbs
LOB(documento_descripcion) STORE AS SECUREFILE
    servicio_contratacion_documento_descripcion(
        TABLESPACE servicios_blob_tbs
    )
;

--
-- Tabla: historico_status_servicio
--
CREATE TABLE historico_status_servicio(
    historico_status_servicio_id        NUMBER(10,0)                NOT NULL,
    fecha_status                        TIMESTAMP DEFAULT SYSDATE   NOT NULL,
    servicio_contratacion_id            NUMBER(10,0)                NOT NULL,
    status_servicio_contratacion_id     NUMBER(1,0)                 NOT NULL,
    CONSTRAINT historico_status_servicio_pk
        PRIMARY KEY(historico_status_servicio_id)
        USING INDEX TABLESPACE servicios_indexes_tbs,
    CONSTRAINT historico_status_servicio_servicio_contratacion_id_fk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_contratacion(servicio_contratacion_id),
    CONSTRAINT historico_status_servicio_status_servicio_contratacion_id_fk
        FOREIGN KEY(status_servicio_contratacion_id)
        REFERENCES status_servicio_contratacion(status_servicio_contratacion_id)
)
PCTFREE 10
TABLESPACE servicios_historico_tbs
;

--
-- Tabla: deposito_cuenta_proveedor
--
CREATE TABLE deposito_cuenta_proveedor(
    deposito_cuenta_proveedor_id        NUMBER(10,0)                NOT NULL,
    importe                             NUMBER(8,2)                 NOT NULL,
    fecha_deposito                      TIMESTAMP DEFAULT SYSDATE   NOT NULL,
    comprobante_deposito                BLOB                        NOT NULL,
    servicio_contratacion_id            NUMBER(10,0)                NOT NULL,
    CONSTRAINT deposito_cuenta_proveedor_pk
        PRIMARY KEY(deposito_cuenta_proveedor_id)
        USING INDEX TABLESPACE servicios_indexes_tbs,
    CONSTRAINT deposito_cuenta_proveedor_servicio_contratacion_id_fk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_contratacion(servicio_contratacion_id)
)
PCTFREE 10
TABLESPACE servicios_transacciones_tbs
LOB(comprobante_deposito) STORE AS SECUREFILE
    deposito_cuenta_proveedor_comprobante_deposito(
        TABLESPACE servicios_blob_tbs
    )
;

--
-- Tabla: pago_servicio
--
CREATE TABLE pago_servicio(
    servicio_contratacion_id    NUMBER(10,0)                NOT NULL,
    numero_pago                 NUMBER(10,0)                NOT NULL,
    fecha_cargo                 TIMESTAMP DEFAULT SYSDATE   NOT NULL,
    importe                     NUMBER(8,2)                 NOT NULL,
    comision                    NUMBER(8,2)                 NOT NULL,
    CONSTRAINT pago_servicio_pk
        PRIMARY KEY(servicio_contratacion_id, numero_pago)
        USING INDEX TABLESPACE servicios_indexes_tbs,
    CONSTRAINT pago_servicio_servicio_contratacion_id_fk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_contratacion(servicio_contratacion_id)
)
PCTFREE 10
TABLESPACE servicios_transacciones_tbs
;

--
-- Tabla: servicio_aceptacion_oferta
--
CREATE TABLE servicio_aceptacion_oferta(
    servicio_contratacion_id        NUMBER(10,0)        NOT NULL,
    precio                          NUMBER(10,2)        NOT NULL,
    descripcion_oferta              VARCHAR2(1000)      NOT NULL,
    numero_mensualidades            NUMBER(2,0)         NULL,
    documento_oferta                BLOB                NULL,
    CONSTRAINT servicio_aceptacion_oferta_pk
        PRIMARY KEY(servicio_contratacion_id)
        USING INDEX TABLESPACE servicios_indexes_tbs,
    CONSTRAINT servicio_aceptacion_oferta_servicio_contratacion_id_pk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_contratacion(servicio_contratacion_id)
)
PCTFREE 10
TABLESPACE servicios_data_tbs
LOB(documento_oferta) STORE AS SECUREFILE
    servicio_aceptacion_oferta_documento_oferta(
        TABLESPACE servicios_blob_tbs
    )
;

--
-- Tabla: servicio_calificacion
--
CREATE TABLE servicio_calificacion(
    servicio_contratacion_id        NUMBER(10,0)        NOT NULL,
    comentario                      VARCHAR2(1000)      NOT NULL,
    calificacion                    NUMBER(1,0)         NOT NULL,
    CONSTRAINT servicio_calificacion_pk
        PRIMARY KEY(servicio_contratacion_id)
        USING INDEX TABLESPACE servicios_indexes_tbs,
    CONSTRAINT servicio_calificacion_servicio_contratacion_id_pk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_aceptacion_oferta(servicio_contratacion_id)
)
PCTFREE 10
TABLESPACE servicios_data_tbs
;

--
-- Tabla: multimedia_promocion
--
CREATE TABLE multimedia_promocion(
    servicio_contratacion_id        NUMBER(10,0)        NOT NULL,
    numero_multinedia               NUMBER(2,0)         NOT NULL,
    archivo_multimedia              BLOB                NOT NULL,
    formato_multimedia              VARCHAR2(5)         NOT NULL,
    descripcion                     VARCHAR2(500)       NULL,
    CONSTRAINT multimedia_promocion_pk
        PRIMARY KEY(servicio_contratacion_id, numero_multinedia)
        USING INDEX TABLESPACE servicios_indexes_tbs,
    CONSTRAINT multimedia_promocion_servicio_contratacion_id_pk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_aceptacion_oferta(servicio_contratacion_id)
)
PCTFREE 10
TABLESPACE servicios_data_tbs
LOB(archivo_multimedia) STORE AS SECUREFILE
    multimedia_promocion_archivo_multimedia(
        TABLESPACE servicios_blob_tbs
    )
;