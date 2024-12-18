# @Autor:           Luis Antonio Arias Quintero
#                   Gamaliel Rios Lira
# @Fecha:           06 de diciembre de 2024
# @Descripcion      Ejecuta las instrucciones necesarias para levantar el
#                   listener e iniciar la instancia.

#!/bin/bash

echo "Iniciando listener..."
lsnrctl start

echo "Iniciando instancia..."
sqlplus -s  / as sysdba  <<EOF
 startup
EOF
