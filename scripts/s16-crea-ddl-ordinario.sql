-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          3 de diciembre de 2024
-- @Descripcion     Crea los ddl para cada módulo

WHENEVER SQLERROR EXIT ROLLBACK

-- Crea ddl para el módulo proveedores
PROMPT Módulo proveedores
CONNECT hs_proveedores_admin/hs@proveedores
@ddl/tablas/proveedores.sql
@ddl/indices/proveedores.sql
@ddl/secuencias/proveedores.sql

-- Crea ddl para el módulo clientes
PROMPT Módulo clientes
CONNECT hs_clientes_admin/hs@clientes
@ddl/tablas/clientes.sql
@ddl/indices/clientes.sql
@ddl/secuencias/clientes.sql

-- Crea ddl para el módulo servicios
PROMPT Módulo servicios
CONNECT hs_servicios_admin/hs@servicios
@ddl/tablas/servicios.sql
@ddl/indices/servicios.sql
@ddl/secuencias/servicios.sql