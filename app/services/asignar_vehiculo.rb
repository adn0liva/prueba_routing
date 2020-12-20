def AsignarVehiculo
  # ToDo: ver campos serviran de salida, o los que faltan de entrada
  # definimos atributos para el servicio
  attr_accessor :ruta_id
  
  def initialize(params)
    @ruta_id = params[:ruta_id]
  end

  # buscamos una ruta similar, que tenga espacio de tiempo disponible
  def buscar_vehiculo

  end
end