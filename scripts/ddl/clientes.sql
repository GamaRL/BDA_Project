-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     DDL para el módulo de clientes

--
-- Tabla: cliente
--
CREATE TABLE cliente(
    cliente_id          NUMBER(10,0)            NOT NULL,
    fecha_registro      DATE DEFAULT SYSDATE    NOT NULL,
    username            VARCHAR2(15)            NOT NULL,
    contrasena          VARCHAR2(16)            NOT NULL,
    email               VARCHAR2(30)            NOT NULL,
    telefono            NUMBER(10,0)            NOT NULL,
    direccion           VARCHAR2(100)           NOT NULL,
    tipo                CHAR(1)                 NOT NULL,

    CONSTRAINT cliente_pk PRIMARY KEY(cliente_id)
        USING INDEX TABLESPACE clientes_indexes_tbs
)
SEGMENT CREATION DEFERRED
PCTFREE 10

PARTITION BY HASH(cliente_id)
    PARTITIONS 3
    STORE IN(
        clientes_hash_1_tbs,
        clientes_hash_2_tbs,
        clientes_hash_3_tbs
    )
;

--
-- Tabla: empresa
--
CREATE TABLE empresa(
    cliente_id          NUMBER(10,0)        NOT NULL,
    nombre              VARCHAR2(25)        NOT NULL,
    descripcion         VARCHAR2(150)       NOT NULL,
    logotipo            BLOB                NOT NULL,
    numero_empleado     NUMBER(8,0)         NOT NULL,

    CONSTRAINT empresa_pk PRIMARY KEY(cliente_id)
        USING INDEX TABLESPACE clientes_indexes_tbs,

    CONSTRAINT empresa_cliente_id_fk FOREIGN KEY(cliente_id)
        REFERENCES cliente(cliente_id)
)
SEGMENT CREATION DEFERRED
PCTFREE 10

PARTITION BY HASH(cliente_id)
    PARTITIONS 3
    STORE IN(
        clientes_hash_1_tbs,
        clientes_hash_2_tbs,
        clientes_hash_3_tbs
    )

LOB(logotipo) STORE AS SECUREFILE
    empresa_logotipo(
        TABLESPACE clientes_blob_tbs
        INDEX empresa_logotipo_ix
            TABLESPACE clientes_indexes_tbs
    )
;

--
-- Tabla: persona
--
CREATE TABLE persona(
    cliente_id          NUMBER(10,0)        NOT NULL,
    nombre              VARCHAR2(50)        NOT NULL,
    foto                BLOB                NOT NULL,
    curp                NUMBER(18,0)        NOT NULL,
    fecha_nacimiento    DATE                NOT NULL,

    CONSTRAINT persona_pk PRIMARY KEY(cliente_id)
        USING INDEX TABLESPACE clientes_indexes_tbs,
    
    CONSTRAINT persona_cliente_id_fk FOREIGN KEY(cliente_id)
        REFERENCES cliente(cliente_id)
)
SEGMENT CREATION DEFERRED
PCTFREE 10

PARTITION BY HASH(cliente_id)
    PARTITIONS 3
    STORE IN(
        clientes_hash_1_tbs,
        clientes_hash_2_tbs,
        clientes_hash_3_tbs
    )

LOB(foto) STORE AS SECUREFILE
    persona_foto(
        TABLESPACE clientes_blob_tbs
        INDEX persona_foto_ix
            TABLESPACE clientes_indexes_tbs
    )
;

--
-- Tabla: tarjeta_cliente
--
CREATE TABLE tarjeta_cliente(
    tarjeta_cliente_id      NUMBER(10,0)    NOT NULL,
    numero_tarjeta          NUMBER(16,0)    NOT NULL,
    anio_expiracion         NUMBER(4,0)     NOT NULL,
    mes_expiracion          NUMBER(2,0)     NOT NULL,
    numero_seguridad        NUMBER(3,0)     NOT NULL,
    banco                   VARCHAR2(30)    NOT NULL,
    cliente_id              NUMBER(10,0)    NOT NULL,

    CONSTRAINT tarjeta_cliente_pk PRIMARY KEY(tarjeta_cliente_id)
        USING INDEX TABLESPACE clientes_indexes_tbs,

    CONSTRAINT tarjeta_cliente_cliente_id_fk FOREIGN KEY(cliente_id)
        REFERENCES cliente(cliente_id)
)
SEGMENT CREATION DEFERRED
PCTFREE 10

TABLESPACE clientes_tarjeta_tbs
;