# @Autor:           Luis Antonio Arias Quintero
#                   Gamaliel Rios Lira
# @Fecha:           13 de noviembre de 2024
# @Descripcion      Crea loop devices y sus respectivos puntos de montaje
#                   para los grupos de Online Redo Logs y Control Files

#!/bin/bash

# Comprueba que el script lo está ejecutando el usuario root
if [ "${USER}" != "root" ]; then
    echo "ERROR: El script lo debe de ejecutar el usuario root."
    exit 1
fi;

# Define el número total de discos a simular
total_discos=3

# Genera dinámicamente el array de nombres de imágenes
archivos_imagen=()
for ((i=1; i<=total_discos; i++)); do
    archivos_imagen+=("disk$(printf "%02d" $i).img")
done;

# Verifica la existencia de la carpeta /unam/bda/proyecto/disk-images
if ! [ -d /unam/bda/proyecto/disk-images ]; then
    # Si no existe, crea el directorio.
    mkdir -p /unam/bda/proyecto/disk-images
fi;

# En caso de existir, elimina el contenido dentro de este
cd /unam/bda/proyecto/disk-images
echo "Para confirmar la eliminación del contenido de ${PWD} presione [ENTER], para dimitir [Ctrl + C]."
read
rm -rf *

# Crea los archivos representativos de cada loop device
for archivo in "${archivos_imagen[@]}"; do
    dd if=/dev/zero of=${archivo} bs=100M count=10
done;

# Comprueba la existencia de los archivos.
for archivo in "${archivos_imagen[@]}"; do
    if ! [ -f ${archivo} ]; then
        # En caso de no existir, genera error y detiene la ejecución del script
        echo "ERROR: El archivo ${archivo} no existe."
        exit 1
    fi;
done;

# Muestra la información de los archivos
du -sh disk*.img

# Crea los loop devices de cada archivo
for archivo in "${archivos_imagen[@]}"; do
    losetup -fP ${archivo}
done;

# Confirma la creación de los loop devices
losetup -a
echo "Para verificar la creación de los loop devices presione [ENTER], para dimitir [Ctrl + C]."
read

# Aplica el formato ext4 a cada loop device
for archivo in "${archivos_imagen[@]}"; do
    mkfs.ext4 ${archivo}
done;

# Crear los directorios donde los dispositivos serán montados
for i in $(seq 1 ${total_discos}); do
    # Verifica la existencia de la carpeta.
    if ! [ -d /unam/bda/proyecto/disks/d0${i} ]; then
        # Si no existe, crea el directorio.
        mkdir -p /unam/bda/proyecto/disks/d0${i}
    fi;

    # En caso de existir, elimina el contenido dentro de este.
    cd /unam/bda/proyecto/disks/d0${i}
    echo "Para confirmar la eliminación del contenido de ${PWD} presione [ENTER], para dimitir [Ctrl + C]."
    read
    rm -rf *
done;

# Comando de verificación que se coloca manualmente en la terminal.
echo "Ejecutar: mount -o loop /dev/loop<número> /unam/bda/proyecto/disks/d0<número> para verificar el funcionamiento del loop device."
echo "Si todo es correcto, editar el archivo /etc/fstab"