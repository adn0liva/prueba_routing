puts "Cargamos los tipos de carga..."
# cargamos los tipos de carga, les entregamos el id para poder usar constantes en el modelo
tipos_de_carga = [
  {id: 1, name: 'General'},
  {id: 2, name: 'Refrigerada'}
]
tipos_de_carga.each do |tc_hash|
  tc_objeto = LoadType.find_or_create_by(id: tc_hash[:id])
  tc_objeto.update(name: tc_hash[:name])
end