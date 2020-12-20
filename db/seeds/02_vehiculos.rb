# agregamos vehiculos base para realizar pruebas
vehiculos = [
  { id: 1, capacity: 25, load_type_id: LoadType::TC_GENERAL_ID },
  { id: 2, capacity: 60, load_type_id: LoadType::TC_GENERAL_ID },
  { id: 3, capacity: 200, load_type_id: LoadType::TC_GENERAL_ID },
  { id: 4, capacity: 25, load_type_id: LoadType::TC_REFRIGERADA_ID },
  { id: 5, capacity: 60, load_type_id: LoadType::TC_REFRIGERADA_ID },
  { id: 6, capacity: 200, load_type_id: LoadType::TC_REFRIGERADA_ID }
]
vehiculos.each do |v_hash|
  v_objecto = Vehicle.find_or_create_by(id: v_hash[:id])
  v_objecto.update(v_hash.slice!(:id))
end