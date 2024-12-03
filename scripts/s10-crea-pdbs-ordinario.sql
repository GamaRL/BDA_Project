-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          2 de diciembre de 2024
-- @Descripcion     Crea las PDBs de los siguientes módulo:
--                  + proveedores
--                  + clientes
--                  + servicios

-- Inicia como CDB$ROOT
CONNECT sys/system3 AS sysdba;

-- Crea la PDB de proveedores
CREATE PLUGGABLE DATABASE proveedores
    ADMIN USER arri_admin IDENTIFIED BY arri_admin
    path_prefix = '/opt/oracle/oradata/FREE'
    file_name_convert = ('/pdbseed/', '/proveedores/');

-- Crea la PDB de clientes
CREATE PLUGGABLE DATABASE clientes
    ADMIN USER arri_admin IDENTIFIED BY arri_admin
    path_prefix = '/opt/oracle/oradata/FREE'
    file_name_convert = ('/pdbseed/', '/clientes/');

-- Crea la PDB de servicios
CREATE PLUGGABLE DATABASE servicios
    ADMIN USER arri_admin IDENTIFIED BY arri_admin
    path_prefix = '/opt/oracle/oradata/FREE'
    file_name_convert = ('/pdbseed/', '/servicios/');

-- Abre todas las PDBs
ALTER PLUGGABLE DATABASE ALL OPEN;

-- Guarda el estado de todas las PDBs
ALTER PLUGGABLE DATABASE ALL SAVE STATE;

PROMPT Agregar los alias de servicio en tnsnames.ora