namespace :rutas do
  desc "Tarea que asigna rutas a id recibido"
  task :asignar_vehiculo_conductor, [:ruta_id] => :environment do |t,args|
    ruta_id_ = args.ruta_id.nil? ? nil : args.ruta_id
    if ruta_id_.nil?
      puts "Debe ingresar Ruta ID"
    else
      salida = AsignarVehiculo.new({ruta_id: ruta_id_}).call
      p salida[:mensaje]
    end
  end
end
