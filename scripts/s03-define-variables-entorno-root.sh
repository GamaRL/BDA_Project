# @Autor:           Luis Antonio Arias Quintero
#                   Gamaliel Rios Lira
# @Fecha:           13 de noviembre de 2024
# @Descripcion      Define las variables de entorno para Oracle Database
#                   SQL*PLUS y RMAN

#!/bin/bash

user="$(whoami)"

# Verifica que el usuario sea diferente al root
if [ "${user}" != 'root' ]; then
    echo "ERROR: El script lo debe de ejecutar el usuario root."
    exit 1
fi;

# Configura las variables de entorno de Oracle

echo \
"# Variables de entorno para Oracle
export ORACLE_HOSTNAME=${HOSTNAME}
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=\$ORACLE_BASE/product/23ai/dbhomeFree
export ORA_INVENTORY=\$ORACLE_BASE/oraInventory
export ORACLE_SID=free
export NLS_LANG=American_America.AL32UTF8
export PATH=\$ORACLE_HOME/bin:\$PATH
export LD_LIBRARY_PATH=\$ORACLE_HOME/lib:\$LD_LIBRARY_PATH

# Variables para acceder a Oracle a través del listener
export TNS_ADMIN=${ORACLE_HOME}/network/admin

# Alias globales
alias sqlplus='rlwrap sqlplus'

# Variables para RMAN
export NLS_DATE_FORMAT='yyyy/mm/dd hh24:mi:ss'
alias rman='rlwrap rman'
">>/etc/profile.d/99-custom-env.sh

echo "Reinicia el contenedor"