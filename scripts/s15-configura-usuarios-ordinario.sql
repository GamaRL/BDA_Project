-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion:    Configura usuarios y quotas para House Services
--                  en las CDB y cada PDB

WHENEVER SQLERROR EXIT ROLLBACK

-- Inicia como sys en cdb$root
CONNECT sys/system3 AS sysdba

-- Crea un usuario común a toda la CDB
DROP USER IF EXISTS c##hs_backup_admin CASCADE;
CREATE USER c##hs_backup_admin
    IDENTIFIED BY hs
    QUOTA unlimited ON users
    CONTAINER = all;

-- Asigna el rol de sysbackup al usuario anterior
GRANT sysbackup TO c##hs_backup_admin
    CONTAINER = all;



-- Inicia como sys en proveedores
CONNECT sys/system3@proveedores AS sysdba

-- Crea un usuario local para la PDB proveedores
DROP USER IF EXISTS hs_proovedores_admin CASCADE;
CREATE USER hs_proovedores_admin
    IDENTIFIED BY hs;

-- Define el tablespace por defecto del usuario anterior
ALTER USER hs_proovedores_admin DEFAULT TABLESPACE proveedores_data_tbs;

-- Asigna quotas al usuario anterior
ALTER USER hs_proovedores_admin QUOTA unlimited ON proveedores_indexes_tbs;
ALTER USER hs_proovedores_admin QUOTA unlimited ON proveedores_blob_tbs;
ALTER USER hs_proovedores_admin QUOTA unlimited ON proveedores_data_tbs;
ALTER USER hs_proovedores_admin QUOTA unlimited ON proveedores_c_bancaria_tbs;

-- Asigna privilegios al usuario anterior
GRANT
    create session,
    create sequence,
    create procedure,
    create table,
    create any index
TO hs_proovedores_admin;



-- Inicia como sys en clientes
CONNECT sys/system3@clientes AS sysdba

-- Crea un usuario local para la PDB clientes
DROP USER IF EXISTS hs_clientes_admin CASCADE;
CREATE USER hs_clientes_admin
    IDENTIFIED BY hs;

-- Define el tablespace por defecto del usuario anterior
ALTER USER hs_clientes_admin DEFAULT TABLESPACE clientes_hash_1_tbs;

-- Asigna quotas al usuario anterior
ALTER USER hs_clientes_admin QUOTA unlimited ON clientes_indexes_tbs;
ALTER USER hs_clientes_admin QUOTA unlimited ON clientes_blob_tbs;
ALTER USER hs_clientes_admin QUOTA unlimited ON clientes_hash_1_tbs;
ALTER USER hs_clientes_admin QUOTA unlimited ON clientes_hash_2_tbs;
ALTER USER hs_clientes_admin QUOTA unlimited ON clientes_hash_3_tbs;
ALTER USER hs_clientes_admin QUOTA unlimited ON clientes_tarjeta_tbs;

-- Asigna privilegios al usuario anterior
GRANT
    create session,
    create sequence,
    create procedure,
    create table,
    create any index
TO hs_clientes_admin;



-- Inicia como sys en servicios
CONNECT sys/system3@servicios AS sysdba

-- Crea un usuario local para la PDB servicios
DROP USER IF EXISTS hs_servicios_admin CASCADE;
CREATE USER hs_servicios_admin
    IDENTIFIED BY hs;

-- Define el tablespace por defecto del usuario anterior
ALTER USER hs_servicios_admin DEFAULT TABLESPACE servicios_data_tbs;

-- Asigna quotas al usuario anterior
ALTER USER hs_servicios_admin QUOTA unlimited ON servicios_indexes_tbs;
ALTER USER hs_servicios_admin QUOTA unlimited ON servicios_blob_tbs;
ALTER USER hs_servicios_admin QUOTA unlimited ON servicios_data_tbs;
ALTER USER hs_servicios_admin QUOTA unlimited ON servicios_historico_tbs;
ALTER USER hs_servicios_admin QUOTA unlimited ON servicios_contratacion_tbs;
ALTER USER hs_servicios_admin QUOTA unlimited ON servicios_transacciones_tbs;

-- Asigna privilegios al usuario anterior
GRANT
    create session,
    create sequence,
    create procedure,
    create table,
    create any index
TO hs_servicios_admin;