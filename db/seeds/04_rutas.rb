hora_base =  Time.parse('2020-12-21 08:00')
rutas = [
  { id: 1, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 8, cities: ['Santiago','Estacion central', 'Providencia'], stops_amount: 8 },
  { id: 2, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 8, cities: ['Santiago','Estacion central', 'Providencia'], stops_amount: 8 },
  { id: 3, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 8, cities: ['Santiago','Estacion central', 'Providencia'], stops_amount: 8 },
  
  { id: 4, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 28, cities: ['Las condes','Vitacura', 'Lo barnechea'], stops_amount: 25 },
  { id: 5, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 28, cities: ['Las condes','Vitacura', 'Lo barnechea'], stops_amount: 25 },
  { id: 6, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 28, cities: ['Las condes','Vitacura', 'Lo barnechea'], stops_amount: 25 },
  
  { id: 7, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 58, cities: ['Maipu','Pudahuel','Lo prado'], stops_amount: 50 },
  { id: 8, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 58, cities: ['Maipu','Pudahuel','Lo prado'], stops_amount: 50 },
  { id: 9, load_type_id: LoadType::TC_GENERAL_ID, load_sum: 58, cities: ['Maipu','Pudahuel','Lo prado'], stops_amount: 50 },
  
  { id: 10, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 8, cities: ['Santiago','Estacion central', 'Providencia'], stops_amount: 8 },
  { id: 11, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 8, cities: ['Santiago','Estacion central', 'Providencia'], stops_amount: 8 },
  { id: 12, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 8, cities: ['Santiago','Estacion central', 'Providencia'], stops_amount: 8 },
  
  { id: 13, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 28, cities: ['Las condes','Vitacura', 'Lo barnechea'], stops_amount: 25 },
  { id: 14, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 28, cities: ['Las condes','Vitacura', 'Lo barnechea'], stops_amount: 25 },
  { id: 15, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 28, cities: ['Las condes','Vitacura', 'Lo barnechea'], stops_amount: 25 },
  
  { id: 16, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 58, cities: ['Maipu','Pudahuel','Lo prado'], stops_amount: 50 },
  { id: 17, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 58, cities: ['Maipu','Pudahuel','Lo prado'], stops_amount: 50 },
  { id: 18, load_type_id: LoadType::TC_REFRIGERADA_ID, load_sum: 58, cities: ['Maipu','Pudahuel','Lo prado'], stops_amount: 50 },
]
contador = 0
rutas.each_with_index do |r_hash, index|
  hora_base_duplicada = hora_base.dup
  r_objeto = Route.find_or_initialize_by(id: r_hash[:id])
  # le asignamos las horas de partida
  r_hash[:starts_at] = hora_base_duplicada + (4*contador).hours
  r_hash[:ends_at] = hora_base_duplicada + (4*(contador+1)).hours
  r_objeto.update(r_hash.slice!(:id))
  # cada 3 reiniciamos "el dia"
  if ((index+1)%3 == 0)
    contador = 0
  else 
    contador += 1
  end
end