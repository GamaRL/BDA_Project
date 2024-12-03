-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Crea los tablespaces para cada módulo

whenever sqlerror exit rollback

--------------------------
--  MÓDULO PROVEEDORES  --
--------------------------

connect sys/system3@proveedores as sysdba;

-- Si existen los tablespaces, los elimina
drop tablespace if exists proveedores_indexes_tbs including contents and datafiles;
drop tablespace if exists proveedores_blob_tbs including contents and datafiles;
drop tablespace if exists proveedores_default_tbs including contents and datafiles;
drop tablespace if exists proveedores_cuenta_bancaria_tbs including contents and datafiles;

--
-- Tablespace: proveedores_indexes_tbs
--
create tablespace proveedores_indexes_tbs
    datafile
        '/unam/bda/proyecto/disks/d04/proveedores_indexes_01.dbf' size 100m,
        '/unam/bda/proyecto/disks/d05/proveedores_indexes_02.dbf' size 100m,
        '/unam/bda/proyecto/disks/d06/proveedores_indexes_03.dbf' size 100m
    autoextend on next 50m maxsize 450m
    extent management local autoallocate
    segment space management auto
    default
        index compress advanced low
;

--
-- Tablespace: proveedores_blob_tbs
--
create bigfile tablespace proveedores_blob_tbs
    datafile '/unam/bda/proyecto/disks/d07/proveedores_blob_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: proveedores_data_tbs
--
create bigfile tablespace proveedores_data_tbs
    datafile '/unam/bda/proyecto/disks/d08/proveedores_data_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: proveedores_cuenta_bancaria_tbs
--
create bigfile tablespace proveedores_cuenta_bancaria_tbs
    datafile '/unam/bda/proyecto/disks/d08/proveedores_cuenta_bancaria_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
;


--------------------------------------------------------------------------------------------------------------------------------


--------------------------
--   MÓDULO CLIENTES    --
--------------------------

connect sys/system3@clientes as sysdba;

-- Si existen los tablespaces, los elimina
drop tablespace if exists clientes_indexes_tbs including contents and datafiles;
drop tablespace if exists clientes_blob_tbs including contents and datafiles;
drop tablespace if exists clientes_hash_1_tbs including contents and datafiles;
drop tablespace if exists clientes_hash_2_tbs including contents and datafiles;
drop tablespace if exists clientes_hash_3_tbs including contents and datafiles;
drop tablespace if exists clientes_tarjeta_cliente_tbs including contents and datafiles;

--
-- Tablespace: clientes_indexes_tbs
--
create tablespace clientes_indexes_tbs
    datafile
        '/unam/bda/proyecto/disks/d09/clientes_indexes_01.dbf' size 100m,
        '/unam/bda/proyecto/disks/d10/clientes_indexes_02.dbf' size 100m,
        '/unam/bda/proyecto/disks/d11/clientes_indexes_03.dbf' size 100m
    autoextend on next 50m maxsize 450m
    extent management local autoallocate
    segment space management auto
    default
        index compress advanced low
;

--
-- Tablespace: clientes_blob_tbs
--
create bigfile tablespace clientes_blob_tbs
    datafile '/unam/bda/proyecto/disks/d12/clientes_blob_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: clientes_hash_1_tbs
--
create bigfile tablespace clientes_hash_1_tbs
    datafile '/unam/bda/proyecto/disks/d13/clientes_hash_1_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: clientes_hash_2_tbs
--
create bigfile tablespace clientes_hash_2_tbs
    datafile '/unam/bda/proyecto/disks/d14/clientes_hash_2_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: clientes_hash_3_tbs
--
create bigfile tablespace clientes_hash_3_tbs
    datafile '/unam/bda/proyecto/disks/d15/clientes_hash_3_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: clientes_tarjeta_cliente_tbs
--
create bigfile tablespace clientes_tarjeta_cliente_tbs
    datafile '/unam/bda/proyecto/disks/d16/clientes_tarjeta_cliente_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
;


--------------------------------------------------------------------------------------------------------------------------------


--------------------------
--   MÓDULO SERVICIOS   --
--------------------------

connect sys/system3@servicios as sysdba;

-- Si existen los tablespaces, los elimina
drop tablespace if exists servicios_indexes_tbs including contents and datafiles;
drop tablespace if exists servicios_blob_tbs including contents and datafiles;
drop tablespace if exists servicios_default_tbs including contents and datafiles;
drop tablespace if exists servicios_historico_tbs including contents and datafiles;
drop tablespace if exists servicios_servicio_contratacion_tbs including contents and datafiles;
drop tablespace if exists servicios_transacciones_tbs including contents and datafiles;

--
-- Tablespace: servicios_indexes_tbs
--
create tablespace servicios_indexes_tbs
    datafile
        '/unam/bda/proyecto/disks/d17/servicios_indexes_17.dbf' size 100m,
        '/unam/bda/proyecto/disks/d18/servicios_indexes_18.dbf' size 100m,
        '/unam/bda/proyecto/disks/d19/servicios_indexes_19.dbf' size 100m
    autoextend on next 50m maxsize 450m
    extent management local autoallocate
    segment space management auto
    default
        index compress advanced low
;

--
-- Tablespace: servicios_blob_tbs
--
create bigfile tablespace servicios_blob_tbs
    datafile '/unam/bda/proyecto/disks/d20/servicios_blob_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: servicios_data_tbs
--
create bigfile tablespace servicios_data_tbs
    datafile '/unam/bda/proyecto/disks/d21/servicios_data_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: servicios_historico_tbs
--
create tablespace servicios_historico_tbs
    datafile
        '/unam/bda/proyecto/disks/d22/servicios_historico_01.dbf' size 333m,
        '/unam/bda/proyecto/disks/d23/servicios_historico_02.dbf' size 333m,
        '/unam/bda/proyecto/disks/d24/servicios_historico_03.dbf' size 334m
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
    default
        table compress for archive low
;

--
-- Tablespace: servicios_servicio_contratacion_tbs
--
create tablespace servicios_servicio_contratacion_tbs
    datafile 
        '/unam/bda/proyecto/disks/d25/servicios_servicio_contratacion_01.dbf' size 333m,
        '/unam/bda/proyecto/disks/d26/servicios_servicio_contratacion_02.dbf' size 333m,
        '/unam/bda/proyecto/disks/d27/servicios_servicio_contratacion_03.dbf' size 334m
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: servicios_transacciones_tbs
--
create bigfile tablespace servicios_transacciones_tbs
    datafile '/unam/bda/proyecto/disks/d21/servicios_transacciones_01.dbf' size 1g
    autoextend on next 100m maxsize 2g
    extent management local autoallocate
    segment space management auto
;