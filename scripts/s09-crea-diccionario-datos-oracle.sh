# @Autor:           Luis Antonio Arias Quintero
#                   Gamaliel Rios Lira
# @Fecha:           20 de noviembre de 2024
# @Descripcion      Crea el diccionario de datos de la Base de Datos

#!/bin/bash

# Comprueba que el script lo está ejecutando el usuario oracle
if [ "${USER}" != "oracle" ]; then
    echo "ERROR: El script lo debe de ejecutar el usuario oracle."
    exit 1
fi;

# Crea un directorio temporal
mkdir /tmp/dd-logs

# Accede al directorio
cd /tmp/dd-logs

# Limpia el directorio
echo "Para confirmar la eliminación del contenido de ${PWD} presione [ENTER], para dimitir [Ctrl + C]."
read
rm -rf *

# Crea el diccionario de datos.
echo -e "\nADVERTENCIA: Este proceso puede tardar cerca de una hora. Presione [ENTER] para continuar o para dimitir [Ctrl + C].\n"
read
perl -I $ORACLE_HOME/rdbms/admin \
$ORACLE_HOME/rdbms/admin/catcdb.pl \
--logDirectory /tmp/dd-logs \
--logFilename dd.log \
--logErrorsFilename dderror.log

# Válida la creación del Diccionario de Datos
sqlplus -s sys/system3 as sysdba << EOF
set serveroutput on
exec dbms_dictionary_check.full
EOF