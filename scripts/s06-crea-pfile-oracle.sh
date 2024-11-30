# @Autor:           Luis Antonio Arias Quintero
#                   Gamaliel Rios Lira
# @Fecha:           13 de noviembre de 2024
# @Descripcion      Crea el PFILE

#!/bin/bash

# Comprueba que el script lo está ejecutando el usuario oracle.
if [ "${USER}" != "oracle" ]; then
    echo "ERROR: El script lo debe de ejecutar el usuario oracle."
    exit 1
fi;

# Define el directorio y nombre del archivo
PFILE=${ORACLE_HOME}/dbs/init${ORACLE_SID}.ora

# Verifica la existencia del archivo
if [ -f ${PFILE} ]; then
    echo "ERROR: El PFILE ya existe."
    exit 1
fi;

# Agrega los parámetros al PFILE.
echo \
"db_name=${ORACLE_SID}
memory_target=768M
db_domain=fi.unam
db_recovery_file_dest_size=2G
db_recovery_file_dest='/unam/bda/proyecto/disks/d00'
db_flashback_retention_target=10080
enable_pluggable_database=true

">>${PFILE}

# Verificando que realmente se haya creado el PFILE.
ls -l ${PFILE}
