-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Crea los tablespaces para cada módulo

WHENEVER SQLERROR EXIT ROLLBACK

-- Crea tablespaces para el módulo proveedores
CONNECT sys/system3@proveedores AS sysdba
@tablespaces/proveedores.sql

-- Crea tablespaces para el módulo clientes
CONNECT sys/system3@clientes AS sysdba
@tablespaces/clientes.sql

-- Crea tablespaces para el módulo servicios
CONNECT sys/system3@servicios AS sysdba
@tablespaces/servicios.sql