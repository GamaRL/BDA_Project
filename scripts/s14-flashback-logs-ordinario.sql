-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          5 de diciembre de 2024
-- @Descripcion:    Activa los flashbacks logs y prepara a la BD
--                  para los backups

WHENEVER SQLERROR EXIT ROLLBACK

-- Conecta como sys en cdb$root
CONNECT sys/system3 AS sysdba

-- Aumenta el tamaño de la FRA
ALTER SYSTEM SET db_recovery_file_dest_size = 10g SCOPE = both;

-- Habilita la generacion de flashback logs
ALTER DATABASE FLASHBACK ON;