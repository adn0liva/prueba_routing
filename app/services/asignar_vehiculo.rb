class AsignarVehiculo
  # ToDo: ver campos serviran de salida, o los que faltan de entrada
  # definimos atributos para el servicio
  attr_accessor :ruta_id, :ruta, :vehiculos_disponibles, :vehiculo_a_asignar, :conductor_a_asignar, :salida
  
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
      p rutas_asignadas_por_tipo.pluck(:id)
      # filtramos por fecha
      rutas_asignadas_del_dia = rutas_asignadas_por_tipo.por_dia(ruta.starts_at)
      # ToDo: si hay rutas para el dia buscamos si podemos incluir entre las horas disponibles
      unless rutas_asignadas_del_dia.blank?
        p rutas_asignadas_del_dia.size
      else
        # si no hay rutas para el dia buscamos vehiculos disponibles
        buscar_vehiculos_disponibles()
        # asignamos al conductor
        asignar_conductor()

        p "vehiculo_a_asignar: #{vehiculo_a_asignar}"
        p "conductor_a_asignar: #{conductor_a_asignar}"
        actualizado = actualizamos_ruta()
        # le cambiamos el estado luego de actualizar
        salida[:estado] = actualizado
      end
    end
    salida
  end

  def buscar_vehiculos_disponibles
    # buscamos vehiculos del tipo de carga y que no tengan rutas para la fecha
    vehiculos_sin_ruta = Vehicle.sin_rutas_asignadas(ruta.starts_at)
    # filtramos por tipo de carga y carga maxima
    vehiculos_del_tipo_y_carga = vehiculos_sin_ruta.por_tipo_y_carga_maxima(ruta.load_type_id, ruta.load_sum)
    # retornamos los vehiculos posibles a usar 
    @vehiculos_disponibles = vehiculos_del_tipo_y_carga
  end

  def asignar_conductor
    # revisamos los vehiculos por si tienen conductores (son propios) o son de una flota de vehiculos
    conductor_ideal = nil
    vehiculos_disponibles.each do |vehiculo|
      # si tiene conductor revisamos si es apto para la ruta 
      if vehiculo.tiene_conductor?
        p 'tiene'
        conductor_apto = vehiculo.driver.apto_para_ruta(ruta)
        conductor_ideal = conductor_apto
      else
        # asignamos un conductor que esté disponible
        conductor_ideal = Driver.apto_para_ruta(ruta)
      end
      # recorremos hasta encontrar conductor ideal
      if conductor_ideal.present?
        # asignamos el vehiculo
        @vehiculo_a_asignar = vehiculo if @vehiculo_a_asignar.nil?
        break 
      end
    end
    # seleccionamos el primero si se encontró alguno ideal
    conductor_ideal = conductor_ideal.size > 0 ? conductor_ideal.first : nil
    @conductor_a_asignar = conductor_ideal
  end

  def actualizamos_ruta
    actualizado = false
    # revisamos si tenemos vehiculo seleccionado y conductor asignado para actualizar la ruta
    if vehiculo_a_asignar.present? && conductor_a_asignar.present?
      #ToDo: actualizar ruta
      actualizado = true
    else
      # ToDo: indicamos el error, alguno de los campos está en blanco
    end
    actualizado
  end
end