-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          5 de diciembre de 2024
-- @Descripcion:    Pobla las tablas

WHENEVER SQLERROR EXIT ROLLBACK

-- Módulo proveedores
PROMPT Módulo proveedores
CONNECT hs_proveedores_admin/hs@proveedores
EXECUTE insertar_modulo_proveedores(1000);

-- Módulo clientes
PROMPT Módulo clientes
CONNECT hs_clientes_admin/hs@clientes
EXECUTE insertar_modulo_clientes(10000);

-- Módulo servicios
PROMPT Módulo servicios
CONNECT hs_servicios_admin/hs@servicios
-- Lunes a Viernes: 5000
-- Sábado: 7000
-- Domingo: 3000
EXECUTE insertar_modulo_servicios(3000);

-- Conecta como sys en cdb$root
CONNECT sys/system3 AS sysdba

-- Provoca un Log Switch
ALTER SYSTEM SWITCH LOGFILE;

-- Genera un checkpoint
ALTER SYSTEM CHECKPOINT;