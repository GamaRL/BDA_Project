-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Tablespaces para el módulo de servicios

drop tablespace if exists servicios_indexes_tbs including contents and datafiles;
drop tablespace if exists servicios_blob_tbs including contents and datafiles;
drop tablespace if exists servicios_data_tbs including contents and datafiles;
drop tablespace if exists servicios_historico_tbs including contents and datafiles;
drop tablespace if exists servicios_contratacion_tbs including contents and datafiles;
drop tablespace if exists servicios_transacciones_tbs including contents and datafiles;

--
-- Tablespace: servicios_indexes_tbs
--
create tablespace servicios_indexes_tbs
    datafile
        '/unam/bda/proyecto/disks/d17/servicios_indexes_17.dbf' size 50m,
        '/unam/bda/proyecto/disks/d18/servicios_indexes_18.dbf' size 50m,
        '/unam/bda/proyecto/disks/d19/servicios_indexes_19.dbf' size 50m
    autoextend on next 1m maxsize 250m
    extent management local autoallocate
    segment space management auto
    default
        index compress advanced low
;

--
-- Tablespace: servicios_blob_tbs
--
create bigfile tablespace servicios_blob_tbs
    datafile '/unam/bda/proyecto/disks/d20/servicios_blob_01.dbf' size 500m
    autoextend on next 5m maxsize 1g
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: servicios_data_tbs
--
create bigfile tablespace servicios_data_tbs
    datafile '/unam/bda/proyecto/disks/d21/servicios_data_01.dbf' size 500m
    autoextend on next 5m maxsize 750m
    extent management local autoallocate
    segment space management auto
;

--
-- Tablespace: servicios_historico_tbs
--
create tablespace servicios_historico_tbs
    datafile
        '/unam/bda/proyecto/disks/d22/servicios_historico_01.dbf' size 200m,
        '/unam/bda/proyecto/disks/d23/servicios_historico_02.dbf' size 200m,
        '/unam/bda/proyecto/disks/d24/servicios_historico_03.dbf' size 200m
    autoextend on next 10m maxsize 1g
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: servicios_contratacion_tbs
--
create tablespace servicios_contratacion_tbs
    datafile 
        '/unam/bda/proyecto/disks/d25/servicios_servicio_contratacion_01.dbf' size 200m,
        '/unam/bda/proyecto/disks/d26/servicios_servicio_contratacion_02.dbf' size 200m,
        '/unam/bda/proyecto/disks/d27/servicios_servicio_contratacion_03.dbf' size 200m
    autoextend on next 10m maxsize 1g
    extent management local autoallocate
    segment space management auto
    default
        table compress for oltp
;

--
-- Tablespace: servicios_transacciones_tbs
--
create bigfile tablespace servicios_transacciones_tbs
    datafile '/unam/bda/proyecto/disks/d21/servicios_transacciones_01.dbf' size 500m
    autoextend on next 5m maxsize 750m
    extent management local autoallocate
    segment space management auto
;