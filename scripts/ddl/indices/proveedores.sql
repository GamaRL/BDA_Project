-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          4 de diciembre de 2024
-- @Descripcion     índices para el módulo de proveedores

DROP INDEX IF EXISTS entidad_nombre_entidad_iuk;
DROP INDEX IF EXISTS entidad_clave_entidad_iuk;
DROP INDEX IF EXISTS nivel_escolaridad_grado_escolaridad_iuk;
DROP INDEX IF EXISTS proveedor_nombre_ix;
DROP INDEX IF EXISTS proveedor_apellido_paterno_ix;
DROP INDEX IF EXISTS proveedor_apellido_materno_ix;
DROP INDEX IF EXISTS proveedor_fecha_nacimiento_ix;
DROP INDEX IF EXISTS proveedor_email_iuk;
DROP INDEX IF EXISTS proveedor_email_ix;
DROP INDEX IF EXISTS proveedor_telefono_casa_ix;
DROP INDEX IF EXISTS proveedor_telefono_movil_ix;
DROP INDEX IF EXISTS proveedor_entidad_nacimiento_id_ix;
DROP INDEX IF EXISTS proveedor_nivel_escolaridad_id_ix;
DROP INDEX IF EXISTS proveedor_proveedor_representante_id_ix;
DROP INDEX IF EXISTS cuenta_bancaria_banco_ix;
DROP INDEX IF EXISTS tipo_servicio_nombre_servicio_ix;
DROP INDEX IF EXISTS servicio_proveedor_proveedor_id_ix;
DROP INDEX IF EXISTS servicio_proveedor_tipo_servicio_id_ix;
DROP INDEX IF EXISTS servicio_proveedor_ix;
DROP INDEX IF EXISTS comprobante_experiencia_servicio_proveedor_id_ix;

--
-- Índices: entidad
--
CREATE UNIQUE INDEX entidad_nombre_entidad_iuk
    ON entidad(nombre_entidad)
    TABLESPACE proveedores_indexes_tbs;

CREATE UNIQUE INDEX entidad_clave_entidad_iuk
    ON entidad(clave_entidad)
    TABLESPACE proveedores_indexes_tbs;

--
-- Índices: nivel_escolaridad
--
-- ¿Conviene este?
CREATE UNIQUE INDEX nivel_escolaridad_grado_escolaridad_iuk
    ON nivel_escolaridad(grado_escolaridad)
    TABLESPACE proveedores_indexes_tbs;

--
-- Índices: proveedor
--
CREATE INDEX proveedor_nombre_ix
    ON proveedor(nombre)
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_apellido_paterno_ix
    ON proveedor(apellido_paterno)
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_apellido_materno_ix
    ON proveedor(apellido_materno)
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_fecha_nacimiento_ix
    ON proveedor(TO_CHAR(fecha_nacimiento, 'mm/yyyy'))
    TABLESPACE proveedores_indexes_tbs;

CREATE UNIQUE INDEX proveedor_email_iuk
    On proveedor(email)
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_email_ix
    ON proveedor(SUBSTR(email, INSTR(email, '@') + 1))
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_telefono_casa_ix
    ON proveedor(SUBSTR(telefono_casa, 1, 2))
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_telefono_movil_ix
    ON proveedor(SUBSTR(telefono_movil, 1, 2))
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_entidad_nacimiento_id_ix
    ON proveedor(entidad_nacimiento_id)
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_nivel_escolaridad_id_ix
    ON proveedor(nivel_escolaridad_id)
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX proveedor_proveedor_representante_id_ix
    ON proveedor(proveedor_representante_id)
    TABLESPACE proveedores_indexes_tbs;

--
-- Índices: cuenta_bancaria
--
-- ¿Conviene este?
CREATE INDEX cuenta_bancaria_banco_ix
    ON cuenta_bancaria(banco)
    TABLESPACE proveedores_indexes_tbs;

--
-- Índices: tipo_servicio
--
CREATE INDEX tipo_servicio_nombre_servicio_ix
    ON tipo_servicio(nombre_servicio)
    TABLESPACE proveedores_indexes_tbs;

--
-- Índices: servicio_proveedor
--
CREATE INDEX servicio_proveedor_proveedor_id_ix
    ON servicio_proveedor(proveedor_id)
    TABLESPACE proveedores_indexes_tbs;

CREATE INDEX servicio_proveedor_tipo_servicio_id_ix
    ON servicio_proveedor(tipo_servicio_id)
    TABLESPACE proveedores_indexes_tbs;

-- ¿Conviene este?
CREATE INDEX servicio_proveedor_ix
    ON servicio_proveedor(proveedor_id, tipo_servicio_id)
    TABLESPACE proveedores_indexes_tbs;

--
-- Índices: comprobante_experiencia
--
CREATE INDEX comprobante_experiencia_servicio_proveedor_id_ix
    ON comprobante_experiencia(servicio_proveedor_id)
    TABLESPACE proveedores_indexes_tbs;