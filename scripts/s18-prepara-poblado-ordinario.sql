-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          5 de diciembre de 2024
-- @Descripcion:    Prepara el ambiente antes de comenzar a poblarlo

WHENEVER SQLERROR EXIT ROLLBACK
SET SERVEROUTPUT ON;

-- Módulo proveedores
PROMPT Módulo proveedores
CONNECT hs_proveedores_admin/hs@proveedores
@@redo/catalogos/proveedores.sql
@@redo/proveedores.sql

-- Módulo clientes
PROMPT Módulo clientes
CONNECT hs_clientes_admin/hs@clientes
@@redo/catalogos/clientes.sql
@@redo/clientes.sql

-- Módulo servicios
PROMPT Módulo servicios
CONNECT hs_servicios_admin/hs@servicios
@@redo/catalogos/servicios.sql
@@redo/servicios.sql