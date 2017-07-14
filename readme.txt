IMPORTANT!!!!
=============

En la configuracion del docker-compose hay que especificar la DNS, que debea ser distinta a la otra instancia de opendj
En el docker compose el puerto expuesto y el de docker debe ser distinto al de la otra instancia
En la carpeta data/post hay revisar el fichero que modifica LDAP para especificar el nombre correcto de la imagen de opendj y la dns de openam

find ./data/post -type f -exec sed -i 's/opendj:389/opendj_emp:389/g' {} +
