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
    # devolvemos lista de rutas
    puts "#{I18n.t(:vehicle_id)}\t#{I18n.t(:driver_id)}\t#{I18n.t(:route_id)}\t\t#{I18n.t(:starts_at)}\t\t#{I18n.t(:ends_at)}"
    Route.asignadas.each do |ruta|
      puts "#{ruta.vehicle_id}\t\t#{ruta.driver_id}\t\t#{ruta.id}\t\t#{ruta.starts_at}\t#{ruta.ends_at}"
    end
  end
end
