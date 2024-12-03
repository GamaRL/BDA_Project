-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Crea las tablas de cada módulo

WHENEVER SQLERROR EXIT ROLLBACK

--------------------------
--  MÓDULO PROVEEDORES  --
--------------------------

CONNECT sys/system3 AS SYSDBA;

--
-- Tabla: ENTIDAD
--
CREATE TABLE entidad(
  entidad_id          NUMBER(10,0)    NOT NULL,
  clave_entidad       VARCHAR2(2)     NOT NULL,
  nombre_entidad      VARCHAR2(30)    NOT NULL,

  CONSTRAINT entidad_pk PRIMARY KEY(entidad_id)
    USING INDEX TABLESPACE proveedores_indexes_tbs
)
TABLESPACE proveedores_default_tbs
;

--
-- Tabla: NIVEL_ESCOLARIDAD
--
CREATE TABLE nivel_escolaridad(
  nivel_escolaridad_id    NUMBER(1,0)     NOT NULL,
  grado_escolaridad       NUMBER(20)      NOT NULL,
  descripcion             VARCHAR2(100)   NOT NULL,

  CONSTRAINT nivel_escolaridad_pk PRIMARY KEY(nivel_escolaridad_id)
    USING INDEX TABLESPACE proveedores_indexes_tbs
)
TABLESPACE proveedores_default_tbs
;

--
-- Tabla: PROVEEDOR
--
CREATE TABLE proveedor(
    proveedor_id                    NUMBER(10,0)    NOT NULL,
    nombre                          VARCHAR2(20)    NOT NULL,
    apellido_paterno                VARCHAR2(20)    NOT NULL,
    apellido_materno                VARCHAR2(20)    NOT NULL,
    foto                            BLOB            NOT NULL,
    fecha_nacimiento                DATE            NOT NULL,
    direccion                       VARCHAR2(150)   NOT NULL,
    email                           VARCHAR2(30)    NOT NULL,
    telefono_casa                   VARCHAR2(10)    NOT NULL,
    telefono_movil                  VARCHAR2(10)    NOT NULL,
    identificacion                  BLOB            NOT NULL,
    comprobante_domicilio           BLOB            NOT NULL,
    entidad_nacimiento_id           NUMBER(2,0)     NOT NULL,
    nivel_escolaridad_id            NUMBER(1,0)     NOT NULL,
    proveedor_representante_id      NUMBER(10,0)    NULL,

    CONSTRAINT proveedor_pk PRIMARY KEY(proveedor_id)
      USING INDEX TABLESPACE proveedores_indexes_tbs,

    CONSTRAINT proveedor_entidad_nacimiento_id_fk
        FOREIGN KEY(entidad_nacimiento_id) REFERENCES entidad(entidad_id),
    CONSTRAINT proveedor_nivel_escolaridad_id_fk
        FOREIGN KEY(nivel_escolaridad_id) REFERENCES nivel_escolaridad(nivel_escolaridad_id),
    CONSTRAINT proveedor_proveedor_representande_id_fk
        FOREIGN KEY(proveedor_representante_id) REFERENCES proveedor(proveedor_id)
)
LOB(foto, identificacion, comprobante_domicilio) STORE AS (
  TABLESPACE proveedores_blob_tbs
)
TABLESPACE proveedores_default_tbs
;

--
-- Tabla: CUENTA_BANCARIA
--
CREATE TABLE cuenta_bancaria(
  proveedor_id    NUMBER(10,0)    NOT NULL,
  clabe           NUMBER(18,0)    NOT NULL,
  banco           VARCHAR2(30)    NOT NULL,

  CONSTRAINT cuenta_bancaria_pk PRIMARY KEY(proveedor_id)
    USING INDEX TABLESPACE proveedores_indexes_tbs,
  CONSTRAINT cuenta_bancaria_proveedor_id_fk
    FOREIGN KEY(proveedor_id) REFERENCES proveedor(proveedor_id)
)
TABLESPACE proveedores_cuenta_bancaria_tbs
;

--
-- Tabla: TIPO_SERVICIO
--
CREATE TABLE tipo_servicio(
  tipo_servicio_id    NUMBER(5,0)     NOT NULL,
  nombre_servicio     VARCHAR2(15)    NOT NULL,
  descripcion         VARCHAR2(250)   NOT NULL,

  CONSTRAINT tipo_servicio_pk
    PRIMARY KEY(tipo_servicio_id)
    USING INDEX TABLESPACE proveedores_indexes_tbs
)
TABLESPACE proveedores_default_tbs
;

--
-- Tabla: SERVICIO_PROVEEDOR
--
CREATE TABLE servicio_proveedor(
  servicio_proveedor_id   NUMBER(10,0)    NOT NULL,
  anios_experiencia       NUMBER(2,0)     NOT NULL,
  proveedor_id            NUMBER(10,0)    NOT NULL,
  tipo_servicio_id        NUMBER(5,0)     NOT NULL,

  CONSTRAINT servicio_proveedor_pk
    PRIMARY KEY(servicio_proveedor_id)
    USING INDEX TABLESPACE proveedores_indexes_tbs,
  CONSTRAINT servicio_proveedor_proveedor_id_fk
    FOREIGN KEY(proveedor_id) REFERENCES proveedor(proveedor_id)
)
TABLESPACE proveedores_default_tbs
;

--
-- Tabla: COMPROBANTE_EXPERIENCIA
--
CREATE TABLE comprobante_experiencia(
    comprobante_domicilio_id    NUMBER(10,0)    NOT NULL,
    documento                   BLOB            NOT NULL,
    servicio_proveedor_id       NUMBER(10,0)    NOT NULL,

    CONSTRAINT comprobante_experiencia_pk
      PRIMARY KEY(comprobante_domicilio_id)
      USING INDEX TABLESPACE proveedores_indexes_tbs
)
TABLESPACE proveedores_default_tbs
;

--------------------------
--   MÓDULO CLIENTES    --
--------------------------

--
-- Tabla: CLIENTE
--
CREATE TABLE cliente(
    cliente_id          NUMBER(10,0)        NOT NULL,
    fecha_registro      DATE                NOT NULL,
    username            VARCHAR2(15)        NOT NULL,
    contrasena          VARCHAR2(16)        NOT NULL,
    email               VARCHAR2(30)        NOT NULL,
    telefono            NUMBER(10,0)        NOT NULL,
    direccion           VARCHAR2(100)       NOT NULL,
    tipo                CHAR(1)             NOT NULL,

    CONSTRAINT cliente_pk PRIMARY KEY(cliente_id)
);

--
-- Tabla: EMPRESA
--
CREATE TABLE empresa(
    cliente_id          NUMBER(10,0)        NOT NULL,
    nombre              VARCHAR2(25)        NOT NULL,
    descripcion         VARCHAR2(150)       NOT NULL,
    logotipo            BLOB                NOT NULL,
    numero_empleado     NUMBER(8,0)         NOT NULL,

    CONSTRAINT empresa_pk
        PRIMARY KEY(cliente_id),
    CONSTRAINT empresa_cliente_id_fk
        FOREIGN KEY(cliente_id)
        REFERENCES cliente(cliente_id)
);

--
-- Tabla: PERSONA
--
CREATE TABLE persona(
    cliente_id          NUMBER(10,0)        NOT NULL,
    nombre              VARCHAR2(50)        NOT NULL,
    foto                BLOB                NOT NULL,
    curp                NUMBER(18,0)        NOT NULL,
    fecha_nacimiento    DATE                NOT NULL,

    CONSTRAINT persona_pk
        PRIMARY KEY(cliente_id),
    CONSTRAINT persona_cliente_id_fk
        FOREIGN KEY(cliente_id)
        REFERENCES cliente(cliente_id)
);

--
-- Tabla: TARJETA_CLIENTE
--
CREATE TABLE tarjeta_cliente(
    tarjeta_cliente_id      NUMBER(10,0)    NOT NULL,
    numero_tarjeta          NUMBER(16,0)    NOT NULL,
    anio_expiracion         NUMBER(4,0)     NOT NULL,
    mes_expiracion          NUMBER(2,0)     NOT NULL,
    numero_seguridad        NUMBER(3,0)     NOT NULL,
    banco                   VARCHAR2(30)    NOT NULL,
    cliente_id              NUMBER(10,0)    NOT NULL,

    CONSTRAINT tarjeta_cliente_pk
        PRIMARY KEY(tarjeta_cliente_id),
    CONSTRAINT tarjeta_cliente_cliente_id_fk
        FOREIGN KEY(cliente_id)
        REFERENCES cliente(cliente_id)
);

--------------------------
--   MÓDULO SERVICIOS   --
--------------------------

--
-- Tabla: STATUS_SERVICIO_CONTRATACION
--
CREATE TABLE status_servicio_contratacion(
    status_servicio_contratacion_id         NUMBER(1,0)         NOT NULL,
    nombre_status                           VARCHAR2(15)        NOT NULL,
    descripcion                             VARCHAR2(250)       NOT NULL

    CONSTRAINT status_servicio_contratacion_pk
        PRIMARY KEY(status_servicio_contratacion_id)
);

--
-- Tabla: SERVICIO_CONTRATACION
--
CREATE TABLE servicio_contratacion(
    servicio_contratacion_id            NUMBER(10,0)        NOT NULL,
    fecha_servicio                      DATE                NOT NULL,
    requerimientos_generales            VARCHAR2(1000)      NOT NULL,
    documento_descripcion               BLOB                NOT NULL,
    servicio_proveedor_id_fk            NUMBER(10,0)        NOT NULL,
    tarjeta_cliente_id_fk               NUMBER(10,0)        NOT NULL,
    status_servicio_contratacion_id     NUMBER(1,0)         NOT NULL,

    CONSTRAINT servicio_contratacion_pk
        PRIMARY KEY(servicio_contratacion_id)
);

--
-- Tabla: HISTORICO_STATUS_SERVICIO
--
CREATE TABLE historico_status_servicio(
    historico_status_servicio_id        NUMBER(10,0)    NOT NULL,
    fecha_status                        TIMESTAMP       NOT NULL,
    servicio_contratacion_id            NUMBER(10,0)    NOT NULL,
    status_servicio_contratacion_id     NUMBER(1,0)     NOT NULL,

    CONSTRAINT historico_status_servicio_pk
        PRIMARY KEY(historico_status_servicio_id),
    CONSTRAINT historico_status_servicio_servicio_contratacion_id_fk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_contratacion(servicio_contratacion_id),
    CONSTRAINT historico_status_servicio_status_servicio_contratacion_id_fk
        FOREIGN KEY(status_servicio_contratacion_id)
        REFERENCES status_servicio_contratacion(status_servicio_contratacion_id)
);

--
-- Tabla: DEPOSITO_CUENTA_PROVEEDOR
--
CREATE TABLE deposito_cuenta_proveedor(
    deposito_cuenta_proveedor_id        NUMBER(10,0)    NOT NULL,
    importe                             NUMBER(8,2)    NOT NULL,
    fecha_deposito                      TIMESTAMP       NOT NULL,
    comprobante_deposito                BLOB            NOT NULL,
    servicio_contratacion_id            NUMBER(10,0)    NOT NULL,

    CONSTRAINT deposito_cuenta_proveedor_pk
        PRIMARY KEY(deposito_cuenta_proveedor_id),
    CONSTRAINT deposito_cuenta_proveedor_servicio_contratacion_id_fk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_contratacion(servicio_contratacion_id)
);

--
-- Tabla: PAGO_SERVICIO
--
CREATE TABLE pago_servicio(
    servicio_contratacion_id    NUMBER(10,0)    NOT NULL,
    numero_pago                 NUMBER(10,0)    NOT NULL,
    fecha_cargo                 TIMESTAMP       NOT NULL,
    importe                     NUMBER(8,2)    NOT NULL,
    comision                    NUMBER(8,2)    NOT NULL,

    CONSTRAINT pago_servicio_pk
        PRIMARY KEY(servicio_contratacion_id),
    CONSTRAINT pago_servicio_servicio_contratacion_id_fk
        FOREIGN KEY(servicio_contratacion_id)
);

--
-- Tabla: SERVICIO_ACEPTACION_OFERTA
--
CREATE TABLE servicio_aceptacion_oferta(
    servicio_contratacion_id        NUMBER(10,0)        NOT NULL,
    precio                          NUMBER(10,2)        NOT NULL,
    descripcion_oferta              VARCHAR2(1000)      NOT NULL,
    numero_mensualidades            NUMBER(2,0)         NULL,
    documento_oferta                BLOB                NULL,

    CONSTRAINT servicio_aceptacion_oferta_pk
        PRIMARY KEY(servicio_contratacion_id),
    CONSTRAINT servicio_aceptacion_oferta_servicio_contratacion_id_pk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_contratacion(servicio_contratacion_id)
);

--
-- Tabla: SERVICIO_CALIFICACION
--
CREATE TABLE servicio_calificacion(
    servicio_contratacion_id        NUMBER(10,0)        NOT NULL,
    comentario                      VARCHAR2(1000)      NOT NULL,
    calificacion                    NUMBER(1,0)         NOT NULL,

    CONSTRAINT servicio_calificacion_pk
        PRIMARY KEY(servicio_contratacion_id),
    CONSTRAINT servicio_calificacion_servicio_contratacion_id_pk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_aceptacion_oferta(servicio_contratacion_id)
);

--
-- Tabla: MULTIMEDIA_PROMOCION
--
CREATE TABLE multimedia_promocion(
    servicio_contratacion_id        NUMBER(10,0)        NOT NULL,
    numero_multinedia               NUMBER(2,0)         NOT NULL,
    archivo_multimedia              BLOB                NOT NULL,
    formato_multimedia              VARCHAR2(5)         NOT NULL,
    descripcion                     VARCHAR2(500)       NULL,

    CONSTRAINT multimedia_promocion_pk
        PRIMARY KEY(servicio_contratacion_id),
    CONSTRAINT multimedia_promocion_servicio_contratacion_id_pk
        FOREIGN KEY(servicio_contratacion_id)
        REFERENCES servicio_aceptacion_oferta(servicio_contratacion_id)
);
