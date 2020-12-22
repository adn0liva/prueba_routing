class Driver < ApplicationRecord
  belongs_to :vehicle, optional: true

  # que la cantidad de paradas sea menor o igual al maximo del conductor
  scope :con_paradas_en_rango, ->(cantidad_paradas) {
    # p " cantidad_paradas #{cantidad_paradas}"
    where('max_stops_accepted >= :cantidad_paradas', cantidad_paradas: cantidad_paradas)
  }
  # un conductor es apto siempre que tenga maximo de detenciones mayor o igual a las detenciones de la ruta
  scope :apto_para_ruta, ->(ruta) { 
    conductores_semi_aptos = con_paradas_en_rango(ruta.stops_amount)
    ids_aptos = []
    # buscamos aquel que tenga al menos 1 comuna en comun
    conductores_semi_aptos.each do |conductor|
      ids_aptos << conductor.id if conductor.tiene_comunas_en_ruta?(ruta)
    end
    # p " ids aptos #{ids_aptos}"
    where(id: ids_aptos)
  }

  # metodo que verifica al conductor de un vehiculo disponible, por lo  tanto el conductor también está disponible
  def apto_para_ruta?(ruta)
    es_apto = false
    # si las paradas maximas estan dentro del rango del conductor 
    paradas_dentro_rango = self.max_stops_accepted >= ruta.stops_amount 
    # y las comunas de la ruta son parte de las que usa el conductor es apto
    tiene_comunas_en_comun = self.tiene_comunas_en_ruta?(ruta)
    es_apto = paradas_dentro_rango && tiene_comunas_en_comun
    # retornamos la respuesta
    es_apto
  end

  # aca definir el alcance de las comunas, si al menos tiene una o las tiene todas
  def tiene_comunas_en_ruta?(ruta)
    # si la diferencia de arreglos cambia, habia alguna en ambos lados
    ((ruta.cities - self.cities).size < ruta.cities.size)
    # en caso de decidir que son todas las comunas usar la siguiente linea
    # ((ruta.cities - self.cities).size == 0)
  end
end
