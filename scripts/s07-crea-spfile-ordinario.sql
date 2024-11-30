-- @Autor:           Luis Antonio Arias Quintero
--                   Gamaliel Rios Lira
-- @Fecha:           13 de noviembre de 2024
-- @Descripcion      Crea el SPFILE

-- Autentica como SYS por archivo de passwords
CONNECT sys/Arri1234* AS sysdba

-- Crea el SPFILE a partir del PFILE
CREATE spfile FROM pfile;

-- Verifica la existencia del SPFILE
!ls ${ORACLE_HOME}/dbs/spfile${ORACLE_SID}.ora