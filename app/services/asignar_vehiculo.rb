class AsignarVehiculo
  # definimos atributos para el servicio
  attr_accessor :ruta_id, :ruta, :vehiculos_disponibles, :vehiculo_a_asignar, :conductor_a_asignar, :rutas_asignadas_del_dia, :salida
  
  def initialize(params)
    @ruta_id = params[:ruta_id]
    @ruta = Route.find(@ruta_id)
    @salida = {
      estado: false, mensaje: nil
    }
  end

  # metodo central que realiza la asignacion
  def call
    if ruta.asignada?
      # indicamos que ya fue asignada y no se puede cambiar
      salida[:mensaje] = 'Ruta ya fue asignada'
    else
      actualizado = false
      scope_tipo_carga = ruta.load_type_id == LoadType::TC_GENERAL_ID ? :carga_general : :carga_refrigerada
      # obtenemos rutas asignadas del mismo tipo
      rutas_asignadas_por_tipo = Route.asignadas.send(scope_tipo_carga)
      # filtramos por fecha
      @rutas_asignadas_del_dia = rutas_asignadas_por_tipo.por_dia(ruta.starts_at)
      # si hay rutas para el dia buscamos si podemos incluir entre las horas disponibles
      unless rutas_asignadas_del_dia.blank?
        conductor_vehiculo_asignado = revisar_espacio_en_rutas()
        if conductor_vehiculo_asignado
          actualizado = actualizamos_ruta()
        else
          actualizado = actualizar_ruta_con_vehiculo_conductor()
        end
      else
        actualizado = actualizar_ruta_con_vehiculo_conductor()
      end
      # le cambiamos el estado luego de actualizar
      salida[:estado] = actualizado
      salida[:mensaje] = 'Ruta correctamente asignada' if actualizado
    end
    salida
  end

  def actualizar_ruta_con_vehiculo_conductor
    # buscamos en vehiculos disponibles
    buscar_vehiculos_disponibles()
    # asignamos al conductor
    asignar_conductor()
    # p "conductor agregado de los no asignados"
    actualizado = actualizamos_ruta()
    actualizado
  end

  def revisar_espacio_en_rutas
    encontrarmos_vehiculo_conductor = false
    #agrupamos las rutas de un vehiculo
    rutas_agrupadas = rutas_asignadas_del_dia.group_by{ |u| u.vehicle_id }
    rutas_agrupadas.each do |vehiculo_id, rutas|
      # recorremos las rutas para ver si hay espacio
      rango_horario_usado = comparar_horas_rutas_del_dia(rutas)
      # si el rango esta usado saltamos al siguiente vehiculo
      unless rango_horario_usado
        # si el rango esta disponible, revisamos vehiculo y conductor
        encontrarmos_vehiculo_conductor = asignar_vehiculo_de_rutas(rutas)
        # si se asigno vehiculo, porque el conductor es apto detenemos busqueda
        break if encontrarmos_vehiculo_conductor
      end
    end
    encontrarmos_vehiculo_conductor
  end

  def comparar_horas_rutas_del_dia(rutas)
    horas_usadas = []
    # obtenemos todas las horas usadas
    rutas.each do |ruta_asignada|
      horas_usadas << (ruta_asignada.starts_at..ruta_asignada.ends_at)
    end
    usado = false
    rango_ruta = ruta.starts_at..ruta.ends_at
    # buscamos si hay espacio disponible
    horas_usadas.each do |rango_horas|
      usado = rango_horas.cover?(rango_ruta)
      break if usado
    end
    usado
  end

  ## no usado, se deja por posible uso
  def comparar_horas_rutas(ruta_asignada)
    tiempo_tomado = ruta_asignada.starts_at..ruta_asignada.ends_at
    usado = tiempo_tomado.cover?(ruta.starts_at..ruta.ends_at)
    usado
  end

  def asignar_vehiculo_de_rutas(rutas)
    # todas las rutas son del mismo conductor, asi que obtengo la primera
    primera_ruta = rutas.first
    conductor_ruta = primera_ruta.driver
    vehiculo_asignado = false
    if conductor_ruta.apto_para_ruta?(ruta)
      @vehiculo_a_asignar = primera_ruta.vehicle
      @conductor_a_asignar = conductor_ruta
      vehiculo_asignado = true
    end
    vehiculo_asignado
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
    conductor_ideal = []
    vehiculos_disponibles.each do |vehiculo|
      # si tiene conductor revisamos si es apto para la ruta 
      if vehiculo.tiene_conductor?
        conductor_apto = vehiculo.driver.apto_para_ruta?(ruta)
        conductor_ideal << vehiculo.driver
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
      # Actualizamos la ruta
      actualizado = ruta.update({
        driver_id: conductor_a_asignar.id,
        vehicle_id: vehiculo_a_asignar.id
      })
    else
      # indicamos el error, alguno de los campos está en blanco
      salida[:mensaje] = vehiculo_a_asignar.present? ? 'No se pudo encontrar conductor apto' : 'No se pudo encontrar vehiculo disponible'
    end
    actualizado
  end
end