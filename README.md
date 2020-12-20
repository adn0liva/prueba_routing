# Prueba backend Routing

La prueba consiste en ...

## Instalación
Proyecto en Ruby on Rails con una base de datos postgreSQL.

Usar rvm para instalar la versión 2.6.3 de ruby si no se tiene.
```bash
rvm install 2.6.3
```
Para la instalación del proyecto seguir los siguientes pasos

```bash
# clonar el repositorio
git clone <repo_path>
# ir al directorio
cd <repo_name>
# crear la master key para las credenciales
touch config/master.key; echo <masterkey> >> config/master.key
# configurar las credenciales de la base de datos
EDITOR=vim rails credentials:edit
# agregar las credenciales de postgres por cada ambiente a utilizar
development:
  database:
    username: <postgres_dev_username>
    password: <postgres_dev_password>
    host: <postgres_dev_host>
production:
  database:
    username: <postgres_prod_username>
    password: <postgres_prod_password>
    host: <postgres_prod_host>

# instalar las gemas usadas en el proyecto
bundle
# crear la base de datos y ejecutar las migración
rails db:create
rails db:migrate
# cargar valores base para las pruebas
rails db:seed

```

## Descripción de la Solución
### Planificación de rutas diarias
Caso para asignar set de rutas para un día completo.
Para un día a futuro, mañana o días siguientes; habiendo rutas ya creadas pero sin asignar vehículo y conductor se armará la ruta diaria, agrupando las rutas disponibles de manera que llenen el horario laboral 08:00 a 22:00, por ejemplo. Identificando que las rutas vayan agrupadas además por el tipo de carga y que tengan comunas en común para facilitar la asignación de conductor.
Una vez tenida la ruta para el día completo, se buscará el vehículo apropiado sin rutas para ese día, que pueda transportar la capacidad máxima entre todas las rutas del día, y el tipo de carga que sea (Refrigerada o General).
En caso de que sea un vehículo con conductor propio se asignará el conductor a la ruta.
En caso de ser un vehículo de una flota se le asignará el conductor teniendo en cuenta la capacidad máxima que puede transportar el conductor y las preferencias de comunas que tenga.
### Planificación de rutas on-demand
Caso para agregar rutas una a una a medida que van apareciendo.
Revisar entre las rutas ya asignadas si se puede agregar entre los espacios libres, que tenga horarios sin rutas y que cumplan con los límites de la nueva ruta y el tipo de carga del vehículo sea el adecuado para la nueva ruta. Si lo hay revisar que la capacidad este bajo el máximo del vehículo; las cantidad de detenciones estén bajo las que el conductor manifestó como máximo y las comunas de la ruta sean las que acepta el conductor. 
En caso que el vehículo no sea del tipo de carga o que el conductor del vehículo no circule por las comunas de la ruta se buscará otra espacio entre las rutas ya asignadas, sino se buscará un vehículo que no este siendo utilizado y se le asignará un conductor apropiado.


## Ejecución de la solución

```rails
# ejecutar el servidor, por defecto se levanta en el puerto 3000
rails s 
# ir a ...

## ejecución como tarea rails
rails <contenedor:tarea>
```