-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          2 de diciembre de 2024
-- @Descripcion     Completa los grupos de Online Redo Logs

-- Autentica como sys en la CDB$ROOT
CONNECT sys/system3 AS sysdba
WHENEVER SQLERROR EXIT ROLLBACK

-- Define las ubicaciones de los control files
DEFINE ruta_1 = '/unam/bda/proyecto/disks/d01/app/oracle/oradata/FREE'
DEFINE ruta_2 = '/unam/bda/proyecto/disks/d02/app/oracle/oradata/FREE'
DEFINE ruta_3 = '/unam/bda/proyecto/disks/d03/app/oracle/oradata/FREE'

-- Completa el grupo 1
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_1/online-redo-log-01a.log' TO GROUP 1;
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_2/online-redo-log-01b.log' TO GROUP 1;
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_3/online-redo-log-01c.log' TO GROUP 1;

-- Completa el grupo 2
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_1/online-redo-log-02a.log' TO GROUP 2;
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_2/online-redo-log-02b.log' TO GROUP 2;
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_3/online-redo-log-02c.log' TO GROUP 2;

-- Completa el grupo 3
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_1/online-redo-log-03a.log' TO GROUP 3;
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_2/online-redo-log-03b.log' TO GROUP 3;
ALTER DATABASE ADD LOGFILE MEMBER '&&ruta_3/online-redo-log-03c.log' TO GROUP 3;