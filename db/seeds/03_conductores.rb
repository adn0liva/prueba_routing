# cargamos conductores base para el sistema
conductores = [
  {id: 1, name: 'Juan Perez', phone: '+5691111111', email: 'juperez@conductores.cl'},
  {id: 2, name: 'Jose Perez', phone: '+5691111112', email: 'joperez@conductores.cl'},
  {id: 3, name: 'Luis Perez', phone: '+5691111113', email: 'luperez@conductores.cl', vehicle_id: 3},
  {id: 4, name: 'Rodrigo Perez', phone: '+5691111114', email: 'roperez@conductores.cl'},
  {id: 5, name: 'Carlos Perez', phone: '+5691111115', email: 'caperez@conductores.cl'},
  {id: 6, name: 'Matias Perez', phone: '+5691111116', email: 'maperez@conductores.cl', vehicle_id: 6}
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
