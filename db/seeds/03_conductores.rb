# definimos variables bases
comunas_centro = ['Santiago','Estacion central', 'Providencia']
comunas_oriente = ['Las condes','Vitacura', 'Lo barnechea']
comunas_poniente = ['Maipu','Pudahuel','Lo prado']
# cargamos conductores base para el sistema
conductores = [
  {id: 1, name: 'Juan Perez', phone: '+5691111111', email: 'juperez@conductores.cl', cities: comunas_centro, max_stops_accepted: 15},
  {id: 2, name: 'Jose Perez', phone: '+5691111112', email: 'joperez@conductores.cl', cities: comunas_oriente, max_stops_accepted: 30},
  {id: 3, name: 'Luis Perez', phone: '+5691111113', email: 'luperez@conductores.cl', vehicle_id: 3, cities: comunas_poniente, max_stops_accepted: 60},
  {id: 4, name: 'Rodrigo Perez', phone: '+5691111114', email: 'roperez@conductores.cl', cities: comunas_centro, max_stops_accepted: 15},
  {id: 5, name: 'Carlos Perez', phone: '+5691111115', email: 'caperez@conductores.cl', cities: comunas_oriente, max_stops_accepted: 30},
  {id: 6, name: 'Matias Perez', phone: '+5691111116', email: 'maperez@conductores.cl', vehicle_id: 6, cities: comunas_poniente, max_stops_accepted: 60},
  # estos 2 no tienen maximo de paradas
  {id: 7, name: 'Pablo Perez', phone: '+5691111117', email: 'paperez@conductores.cl', cities: comunas_oriente},
  {id: 8, name: 'Esteban Perez', phone: '+5691111118', email: 'esperez@conductores.cl', cities: comunas_poniente}
]
conductores.each do |c_hash|
  d_objeto = Driver.find_or_initialize_by(id: c_hash[:id])
  d_objeto.update(c_hash.slice!(:id))
end

# luis y matias son propietarios de sus propios vehiculos
ids_vehiculos_conductores = [
  {vehiculo_id: 3, conductor_id: 3},
  {vehiculo_id: 6, conductor_id: 6}
]
ids_vehiculos_conductores.each do |vc_hash|
  v_objeto = Vehicle.find(vc_hash[:vehiculo_id])
  v_objeto.update(driver_id: vc_hash[:conductor_id])
end
