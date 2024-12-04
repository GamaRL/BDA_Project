-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Tablespaces para el módulo de proveedores

drop tablespace if exists clientes_indexes_tbs including contents and datafiles;
drop tablespace if exists clientes_blob_tbs including contents and datafiles;
drop tablespace if exists clientes_hash_1_tbs including contents and datafiles;
drop tablespace if exists clientes_hash_2_tbs including contents and datafiles;
drop tablespace if exists clientes_hash_3_tbs including contents and datafiles;
drop tablespace if exists clientes_tarjeta_tbs including contents and datafiles;

--
-- Tablespace: clientes_indexes_tbs
--
create tablespace clientes_indexes_tbs
    datafile
        '/unam/bda/proyecto/disks/d09/clientes_indexes_01.dbf' size 50m,
        '/unam/bda/proyecto/disks/d10/clientes_indexes_02.dbf' size 50m,
        '/unam/bda/proyecto/disks/d11/clientes_indexes_03.dbf' size 50m
    autoextend on next 1m maxsize 250m
    extent management local autoallocate
    segment space management auto
    default
        index compress advanced low
;

--
-- Tablespace: clientes_blob_tbs
--
create bigfile tablespace clientes_blob_tbs
    datafile '/unam/bda/proyecto/disks/d12/clientes_blob_01.dbf' size 500m
    autoextend on next 5m maxsize 1g
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: clientes_hash_1_tbs
--
create bigfile tablespace clientes_hash_1_tbs
    datafile '/unam/bda/proyecto/disks/d13/clientes_hash_1_01.dbf' size 500m
    autoextend on next 5m maxsize 750m
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: clientes_hash_2_tbs
--
create bigfile tablespace clientes_hash_2_tbs
    datafile '/unam/bda/proyecto/disks/d14/clientes_hash_2_01.dbf' size 500m
    autoextend on next 5m maxsize 750m
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: clientes_hash_3_tbs
--
create bigfile tablespace clientes_hash_3_tbs
    datafile '/unam/bda/proyecto/disks/d15/clientes_hash_3_01.dbf' size 500m
    autoextend on next 5m maxsize 750m
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: clientes_tarjeta_tbs
--
create bigfile tablespace clientes_tarjeta_tbs
    datafile '/unam/bda/proyecto/disks/d16/clientes_tarjeta_01.dbf' size 500m
    autoextend on next 5m maxsize 750m
    extent management local autoallocate
    segment space management auto
;