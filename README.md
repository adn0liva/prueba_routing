# Prueba backend Routing

La prueba consiste en un problema de scheduling, aplicado a la asignación de rutas a
vehículos de una flota y a un equipo de conductores disponibles. El objetivo es que Ud.
proponga una heurística que entregue una solución factible al problema y la implemente en una
aplicación CLI.

## Instalación
Proyecto en Ruby on Rails con una base de datos postgreSQL.

Usar rvm para instalar la versión 2.6.3 de ruby si no se tiene.
```bash
rvm install 2.6.3
```
Para la instalación del proyecto seguir los siguientes pasos

```bash
# clonar el repositorio
git clone git@github.com:adn0liva/prueba_routing.git
# ir al directorio
cd prueba_routing
# crear la master key para las credenciales
touch config/master.key; echo 07d72ddea223591d8ff02c41c107f311 >> config/master.key
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
# instalar webpacker
rails webpacker:install
# crear la base de datos y ejecutar las migración
rails db:create
rails db:migrate
# cargar valores base para las pruebas
rails db:seed

# si se quieren cargar rutas para pruebas ejecutar tarea
rails insertar:rutas_prueba

```

## Descripción de la Solución

### Planificación de rutas on-demand
Caso para agregar rutas una a una a medida que van apareciendo (creando).
Se verifica que la ruta que se trata de asignar no esté asignada. 
Luego se verifica si hay rutas ya asignadas del mismo tipo de carga y para el mismo día.
Si se encuentran, se verifica que por vehículo tenga espacio de tiempo disponible con el horario de la nueva ruta. Si hay espacio para agregar la nueva ruta, se revisa finalmente al conductor de la ruta ya asignada que la cantidad de paradas máximas sea mayor o igual a la de la nueva ruta y que entre las comunas que son del conductor y las de la ruta, en al menos 1 haya concordancia. Siendo así, se le asigna el vehículo y el conductor a la ruta. Para el caso contrario que el conductor no sea apto, se revisa si hay otra ruta ya asignada de las misma características y se repite el proceso.
En caso de que las rutas ya asignadas no tengan espacio horario para la nueva ruta se asignará un vehículo que tenga el tipo de carga de la ruta y la capacidad necesaria para la ruta; luego se asignará el conductor apropiado que cumpla con la cantidad de detenciones máximas y las comunas de la ruta al menos una sea igual a la del conductor.
En caso de no haber vehículos disponibles o conductores apropiados para la ruta se informará el error.


## Ejecución de la solución

```rails
# ejecutar el servidor, por defecto se levanta en el puerto 3000
rails s 
# Cargará la lista de rutas y se podrá tener acceso a las listas de cada tabla en la base de datos

## ejecución como tarea rails
rails rutas:asignar_vehiculo_conductor[<ruta_id>]

## ejecución a través de consola rails
rails c
# indicar id de ruta a asignar vehículo y conductor
AsignarVehiculo.new({ruta_id: <ruta_id>}).call
```