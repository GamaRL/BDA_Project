-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          2 de diciembre de 2024
-- @Descripcion     Activa el modo de archivado de los Online Redo Logs

-- Autentica como sys en la CDB$ROOT
CONNECT sys/system3 AS sysdba
WHENEVER SQLERROR EXIT ROLLBACK

-- Crea un respaldo del SPFILE
CREATE pfile FROM spfile;

-- Configura 3 procesos ARCn para activar configurar el archivado
-- de los Online Redo Logs
ALTER SYSTEM SET log_archive_max_processes = 2 SCOPE = spfile;

-- Configura las rutas destino de las 2 copias de Archived Redo Logs
ALTER SYSTEM SET log_archive_dest_1 = 'LOCATION=/unam/bda/proyecto/disks/d28/FREE MANDATORY' SCOPE = spfile;
ALTER SYSTEM SET log_archive_dest_2 = 'LOCATION=/unam/bda/proyecto/disks/d29/FREE' SCOPE = spfile;

-- Configura una copia de Archived Redo Logs en la FRA
ALTER SYSTEM SET log_archive_dest_3 = 'LOCATION=USE_DB_RECOVERY_FILE_DEST' SCOPE = spfile;

-- Configura el formato de nombre de los Archived Redo Logs
ALTER SYSTEM SET log_archive_format = 'Archive_Log_%t_%s_%r.arc' SCOPE = spfile;

-- Indica que se debe de generar una copia para que el proceso se
-- considere exitoso
ALTER SYSTEM SET log_archive_min_succeed_dest = 2 SCOPE = spfile;

-- Reinicia la instancia en modo MOUNT
SHUTDOWN IMMEDIATE
STARTUP MOUNT

-- Activa el modo de archivado
ALTER DATABASE ARCHIVELOG;

-- Abre la BD
ALTER DATABASE OPEN;

-- Autentica como SYS en la CDB$ROOT
CONNECT sys/system3 AS sysdba

-- Verifica la configuración del modo de archivado
ARCHIVE LOG LIST

-- Respalda el SPFILE en un nuevo PFILE
CREATE pfile FROM spfile;

-- Aplica un Log Switch para provocar un proceso de archivado
-- de los Online Redo Logs
ALTER SYSTEM SWITCH LOGFILE;
