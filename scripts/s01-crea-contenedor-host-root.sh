# @Autor:           Luis Antonio Arias Quintero
#                   Gamaliel Rios Lira
# @Fecha:           13 de noviembre de 2024
# @Descripción:     Crea el nuevo contenedor a partir de una imagen
#                   pre - configurada. Asimismo, crea un directorio
#                   compartido entre la máquina host y el contenedor

#!/bin/bash

# Verifica que el usuario sea diferente al root
if [ "${USER}" != 'root' ]; then
    echo "ERROR: El script lo debe de ejecutar el usuario root."
    exit 1
fi;

# Crea un nuevos directorios en la raíz de la máquina host
mkdir -p /proyecto-bda/scripts

# Asigna los permisos y dueño
chmod 755 /proyecto-bda/scripts
chown luis:luis /proyecto-bda/scripts

# Agrega los alias de servicio a /etc/bash.bashrc
echo \
"# Alias para el proyecto
alias dockerBda3='docker start c3-bda-arri && docker attach c3-bda-arri'
alias dockerBda3T='docker exec -it c3-bda-arri bash'

">>/etc/bash.bashrc

echo Reiniciar la máquina host al concluir la ejecución del script

# Crea el nuevo contenedor a partir de una imagen
docker run -i -t \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v /unam:/unam \
--name c3-bda-arri \
--hostname d3-bda-arri.fi.unam \
--expose 1521 \
--expose 5500 \
--shm-size=2gb \
-e DISPLAY=$DISPLAY ol-laq:1.0 bash