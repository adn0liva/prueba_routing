# particionamos la carga del seed para separar archivos y manejarlos de mejor manera
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].sort.each do |seed|
  load seed
end