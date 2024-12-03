# @Autor:           Luis Antonio Arias Quintero
#                   Gamaliel Rios Lira
# @Fecha:           13 de noviembre de 2024
# @Descripcion      Crea los directorios para los tablespaces

#!/bin/bash

# Obtiene al usuario que ejecuta el script
user="$(whoami)"

# Comprueba que el script lo está ejecutando el usuario root
if [ "${user}" != "root" ]; then
    echo "ERROR: El script lo debe de ejecutar el usuario root."
    exit 1
fi;

# Define la cantidad de discos a simular en carpetas
numero_discos=31

# Define los discos manejados como loop devices
loop_devices=('d01' 'd02' 'd03')

# Accede al directorio
mkdir -p /unam/bda/proyecto/disks
cd /unam/bda/proyecto/disks

# Crea los discos excluyendo a los loop devices
for ((i=0; i<=numero_discos; i++)); do
    # Define el nombre del disco
    if [ "$i" -lt 10 ]; then
        disco="d0${i}"
    else
        disco="d${i}"
    fi;

    # Verifica si el disco no es loop_devices
    if ! [[ " ${loop_devices[@]} " =~ " ${disco} " ]]; then
        # Si no lo es, lo borra y vuelve a crear
        rm -rf "${disco}"
        mkdir "${disco}"
    fi;

    chown oracle:oinstall "${disco}"
    chmod 750 "${disco}"
done;

# Accede al directorio oracle
cd /opt/oracle

# Verifica la existencia del directorio oradata/${ORACLE_SID^^}
if ! [ -d "oradata/${ORACLE_SID^^}" ]; then
    # En caso de no existir, lo crea.
    mkdir -p oradata/${ORACLE_SID^^}
fi;

# Asigna dueño y grupo de manera recursiva a oradata
chown -R oracle:oinstall oradata
chmod -R 750 oradata

# Accede al directorio ${ORACLE_SID^^}
cd /opt/oracle/oradata/${ORACLE_SID^^}

# Verifica la existencia del directorio pdbseed
if ! [ -d "pdbseed" ]; then
    # En caso de no existir, lo crea
    mkdir -p pdbseed
fi;

# Asigna dueño y grupo a pdbseed
chown oracle:oinstall pdbseed
chmod 750 pdbseed

# Verifica la creación de los directorios
ls -l /unam/bda/proyecto/disks/
ls -l /opt/oracle/oradata/
ls -l /opt/oracle/oradata/${ORACLE_SID^^}