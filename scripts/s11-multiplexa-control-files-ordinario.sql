-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          2 de diciembre de 2024
-- @Descripcion     Multiplexa los control files

-- Inicia como CDB$ROOT
CONNECT sys/system3 AS sysdba
WHENEVER SQLERROR EXIT ROLLBACK

-- Genera un respaldo del PFILE desde el SPFILE
CREATE PFILE FROM SPFILE;

-- Define las ubicaciones de los control files
-- Editar la ruta de la fra
DEFINE fra = '/unam/bda/proyecto/disks/d00/FREE/controlfile/o1_mf_mnx2ybt2_.ctl'
DEFINE ruta_1 = '/unam/bda/proyecto/disks/d01/app/oracle/oradata/FREE/control-file-01.ctl'
DEFINE ruta_2 = '/unam/bda/proyecto/disks/d02/app/oracle/oradata/FREE/control-file-02.ctl'
DEFINE ruta_3 = '/unam/bda/proyecto/disks/d03/app/oracle/oradata/FREE/control-file-03.ctl'

-- Edita el spfile
ALTER SYSTEM SET control_files = '&&fra', '&&ruta_1', '&&ruta_2', '&&ruta_3' SCOPE = spfile;

-- Detiene la instancia
SHUTDOWN IMMEDIATE
STARTUP