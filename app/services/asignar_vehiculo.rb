class AsignarVehiculo
  # ToDo: ver campos serviran de salida, o los que faltan de entrada
  # definimos atributos para el servicio
  attr_accessor :ruta_id, :ruta, :salida
  
  def initialize(params)
    @ruta_id = params[:ruta_id]
    @ruta = Route.find(@ruta_id)
    @salida = {
      estado: false, mensaje: nil
    }
  end

  # buscamos una ruta similar, que tenga espacio de tiempo disponible
  def buscar_vehiculo
    if ruta.asignada?
      # indicamos que ya fue asignada y no se puede cambiar
      salida[:mensaje] = 'Ruta ya fue asignada'
    else
      scope_tipo_carga = ruta.load_type_id == LoadType::TC_GENERAL_ID ? :carga_general : :carga_refrigerada
      # obtenemos rutas asignadas del mismo tipo
      rutas_asignadas_por_tipo = Route.asignadas.send(scope_tipo_carga)
      puts " size: #{rutas_asignadas_por_tipo.size}"
      # filtramos por fecha
      puts "debemos filtrar por fecha 1"
      # si hay rutas para el dia buscamos si podemos incluir entre las horas disponibles
      
      # si no hay rutas buscamos vehiculos disponibles
      
    end
    salida
  end
end