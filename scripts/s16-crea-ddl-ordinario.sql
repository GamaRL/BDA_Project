-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Crea los ddl para cada módulo

WHENEVER SQLERROR EXIT ROLLBACK

-- Crea ddl para el módulo proveedores
PROMPT Módulo proveedores
CONNECT sys/system3@proveedores AS sysdba
@ddl/tablas/proveedores.sql
@ddl/indices/proveedores.sql

-- Crea ddl para el módulo clientes
PROMPT Módulo clientes
CONNECT sys/system3@clientes AS sysdba
@ddl/tablas/clientes.sql
@ddl/indices/clientes.sql

-- Crea ddl para el módulo servicios
PROMPT Módulo servicios
CONNECT sys/system3@servicios AS sysdba
@ddl/tablas/servicios.sql
@ddl/indices/servicios.sql