# @Autor:           Luis Antonio Arias Quintero
#                   Gamaliel Rios Lira
# @Fecha:           13 de noviembre de 2024
# @Descripcion      Crea el archivo de passwords para SYS

#!/bin/bash

# Comprueba que el script lo está ejecutando el usuario oracle.
if [ "${USER}" != "oracle" ]; then
    echo "ERROR: El script lo debe de ejecutar el usuario oracle."
    exit 1
fi;

# Verifica la existencia del directorio de oracle
if ! [ -d ${ORACLE_HOME}/dbs ]; then
    echo "ERROR: El directorio ${ORACLE_HOME}/dbs no existe."
    exit 1
fi;

# Verifica la existencia del archivo de passwords
if ! [ -f ${ORACLE_HOME}/dbs/orapw${ORACLE_SID} ]; then
    echo "Creando archivo de passwords."

    # Crea el archivo de passwords para el usuarios SYS
    # con contraseña Arri1234*
    orapwd FILE='${ORACLE_HOME}/dbs/orapw${ORACLE_SID}' \
    FORMAT=12.2 \
    SYS=password password=Arri1234*
else
    echo "ERROR: El archivo de passwords ya existe."
    exit 1
fi;

# Verificando que realmente se haya creado el archivo de passwords.
ls -l $ORACLE_HOME/dbs/orapw${ORACLE_SID}
