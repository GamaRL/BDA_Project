-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     DDL para el módulo de proveedores

DROP TABLE IF EXISTS comprobante_experiencia;
DROP TABLE IF EXISTS servicio_proveedor;
DROP TABLE IF EXISTS tipo_servicio;
DROP TABLE IF EXISTS cuenta_bancaria;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS nivel_escolaridad;
DROP TABLE IF EXISTS entidad;

--
-- Tabla: entidad
--
CREATE TABLE entidad(
    entidad_id          NUMBER(10,0)    NOT NULL,
    clave_entidad       VARCHAR2(2)     NOT NULL,
    nombre_entidad      VARCHAR2(30)    NOT NULL,
    CONSTRAINT entidad_pk PRIMARY KEY(entidad_id)
        USING INDEX TABLESPACE proveedores_indexes_tbs
)
PCTFREE 10
TABLESPACE proveedores_data_tbs
;

--
-- Tabla: nivel_escolaridad
--
CREATE TABLE nivel_escolaridad(
    nivel_escolaridad_id    NUMBER(1,0)     NOT NULL,
    grado_escolaridad       NUMBER(20)      NOT NULL,
    descripcion             VARCHAR2(100)   NOT NULL,
    CONSTRAINT nivel_escolaridad_pk PRIMARY KEY(nivel_escolaridad_id)
        USING INDEX TABLESPACE proveedores_indexes_tbs
)
PCTFREE 10
TABLESPACE proveedores_data_tbs
;

--
-- Tabla: proveedor
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
PCTFREE 10
TABLESPACE proveedores_data_tbs
LOB(foto) STORE AS SECUREFILE
    proveedor_foto(
        TABLESPACE proveedores_blob_tbs
    )
LOB(identificacion) STORE AS SECUREFILE
    proveedor_identificacion(
        TABLESPACE proveedores_blob_tbs
    )
LOB(comprobante_domicilio) STORE AS SECUREFILE
    proveedor_comprobante_domicilio(
        TABLESPACE proveedores_blob_tbs
    )
;

--
-- Tabla: cuenta_bancaria
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
PCTFREE 10
TABLESPACE proveedores_c_bancaria_tbs
;

--
-- Tabla: tipo_servicio
--
CREATE TABLE tipo_servicio(
    tipo_servicio_id    NUMBER(5,0)     NOT NULL,
    nombre_servicio     VARCHAR2(15)    NOT NULL,
    descripcion         VARCHAR2(250)   NOT NULL,
    CONSTRAINT tipo_servicio_pk PRIMARY KEY(tipo_servicio_id)
        USING INDEX TABLESPACE proveedores_indexes_tbs
)
PCTFREE 10
TABLESPACE proveedores_data_tbs
;

--
-- Tabla: servicio_proveedor
--
CREATE TABLE servicio_proveedor(
    servicio_proveedor_id   NUMBER(10,0)    NOT NULL,
    anios_experiencia       NUMBER(2,0)     NOT NULL,
    proveedor_id            NUMBER(10,0)    NOT NULL,
    tipo_servicio_id        NUMBER(5,0)     NOT NULL,
    CONSTRAINT servicio_proveedor_pk PRIMARY KEY(servicio_proveedor_id)
        USING INDEX TABLESPACE proveedores_indexes_tbs,
    CONSTRAINT servicio_proveedor_proveedor_id_fk
        FOREIGN KEY(proveedor_id) REFERENCES proveedor(proveedor_id)
)
PCTFREE 10
TABLESPACE proveedores_data_tbs
;

--
-- Tabla: comprobante_experiencia
--
CREATE TABLE comprobante_experiencia(
    comprobante_domicilio_id    NUMBER(10,0)    NOT NULL,
    documento                   BLOB            NOT NULL,
    servicio_proveedor_id       NUMBER(10,0)    NOT NULL,
    CONSTRAINT comprobante_experiencia_pk PRIMARY KEY(comprobante_domicilio_id)
        USING INDEX TABLESPACE proveedores_indexes_tbs
)
PCTFREE 10
TABLESPACE proveedores_data_tbs
LOB(documento) STORE AS SECUREFILE
    comprobante_experiencia_documento(
        TABLESPACE proveedores_blob_tbs
    )
;