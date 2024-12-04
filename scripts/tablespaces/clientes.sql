-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Tablespaces para el módulo de clientes

drop tablespace if exists proveedores_indexes_tbs including contents and datafiles;
drop tablespace if exists proveedores_blob_tbs including contents and datafiles;
drop tablespace if exists proveedores_data_tbs including contents and datafiles;
drop tablespace if exists proveedores_c_bancaria_tbs including contents and datafiles;

--
-- Tablespace: proveedores_indexes_tbs
--
create tablespace proveedores_indexes_tbs
    datafile
        '/unam/bda/proyecto/disks/d04/proveedores_indexes_01.dbf' size 50m,
        '/unam/bda/proyecto/disks/d05/proveedores_indexes_02.dbf' size 50m,
        '/unam/bda/proyecto/disks/d06/proveedores_indexes_03.dbf' size 50m
    autoextend on next 1m maxsize 250m
    extent management local autoallocate
    segment space management auto
    default
        index compress advanced low
;

--
-- Tablespace: proveedores_blob_tbs
--
create bigfile tablespace proveedores_blob_tbs
    datafile '/unam/bda/proyecto/disks/d07/proveedores_blob_01.dbf' size 500m
    autoextend on next 5m maxsize 1g
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: proveedores_data_tbs
--
create bigfile tablespace proveedores_data_tbs
    datafile '/unam/bda/proyecto/disks/d08/proveedores_data_01.dbf' size 500m
    autoextend on next 5m maxsize 750m
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: proveedores_c_bancaria_tbs
--
create bigfile tablespace proveedores_c_bancaria_tbs
    datafile '/unam/bda/proyecto/disks/d08/proveedores_c_bancaria_01.dbf' size 500m
    autoextend on next 5m maxsize 750m
    extent management local autoallocate
    segment space management auto
;