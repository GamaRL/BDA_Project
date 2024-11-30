-- @Autor:          Luis Antonio Arias Quintero
--                  Gamaliel Rios Lira
-- @Fecha:          20 de noviembre de 2024
-- @Descripcion     Crea la CDB y homologa la contraseñas

-- Inicia sesión con el usuario sys
CONNECT sys/Arri1234* AS sysdba

-- Inicia la instancia en modo nomount
STARTUP NOMOUNT

-- En caso de error, detiene la ejecución
WHENEVER SQLERROR EXIT ROLLBACK

-- Crea la CDB
CREATE DATABASE free
    USER sys IDENTIFIED BY system3
    USER system IDENTIFIED BY system3
    LOGFILE
        GROUP 1 SIZE 150m BLOCKSIZE 512,
        GROUP 2 SIZE 150m BLOCKSIZE 512,
        GROUP 3 SIZE 150m BLOCKSIZE 512
    MAXLOGHISTORY 1
    MAXLOGFILES 16
    MAXLOGMEMBERS 4
    MAXDATAFILES 1024
    CHARACTER SET AL32UTF8
    NATIONAL CHARACTER SET AL16UTF16
    EXTENT MANAGEMENT LOCAL
        DATAFILE '/opt/oracle/oradata/FREE/system-01.dbf'
            SIZE 500M
            AUTOEXTEND ON NEXT 10M MAXSIZE 11G
        SYSAUX DATAFILE '/opt/oracle/oradata/FREE/sysaux-01.dbf'
            SIZE 300M
            AUTOEXTEND ON NEXT 10M MAXSIZE 11G
        DEFAULT TABLESPACE users
            DATAFILE '/opt/oracle/oradata/FREE/users-01.dbf'
                SIZE 50M
                AUTOEXTEND OFF
        DEFAULT TEMPORARY TABLESPACE tempts1
            TEMPFILE '/opt/oracle/oradata/FREE/temporary-01.dbf'
                SIZE 20M
                AUTOEXTEND ON NEXT 1M MAXSIZE 11G
        UNDO TABLESPACE undotbs1
            DATAFILE '/opt/oracle/oradata/FREE/undotbs-01.dbf'
                SIZE 100M
                AUTOEXTEND ON NEXT 5M MAXSIZE 11G
    ENABLE PLUGGABLE DATABASE
    SEED
        FILE_NAME_CONVERT = (
            '/opt/oracle/oradata/FREE',
            '/opt/oracle/oradata/FREE/pdbseed'
        )
    SYSTEM DATAFILES
        SIZE 250M
        AUTOEXTEND ON NEXT 10M MAXSIZE 11G
    SYSAUX DATAFILES
        SIZE 200M
        AUTOEXTEND ON NEXT 10M MAXSIZE 11G
    LOCAL UNDO ON
;

-- Homolagando constraseñas
ALTER USER sys IDENTIFIED BY system3;
ALTER USER system IDENTIFIED BY system3;