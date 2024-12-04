-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Crea los ddl para cada módulo

WHENEVER SQLERROR EXIT ROLLBACK

-- Crea ddl para el módulo proveedores
CONNECT sys/system3@proveedores AS sysdba
@ddl/proveedores.sql

-- Crea ddl para el módulo clientes
CONNECT sys/system3@clientes AS sysdba
@ddl/clientes.sql

-- Crea ddl para el módulo servicios
CONNECT sys/system3@servicios AS sysdba
@ddl/servicios.sql