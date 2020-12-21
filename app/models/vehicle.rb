class Vehicle < ApplicationRecord
  belongs_to :load_type
  belongs_to :driver, optional: true
  has_many :routes

  # devuelve los vehiculos con ruta hoy
  scope :rutas_por_dia, ->(fecha) { 
    filtro_fecha = { inicio_dia: fecha.beginning_of_day, fin_dia: fecha.end_of_day }
    includes(:routes)
    .where('routes.starts_at >= :inicio_dia AND routes.ends_at <= :fin_dia ', filtro_fecha)
  }
  # devuelve vehiculos sin rutas para fecha seleccionada
  scope :sin_rutas_asignadas, ->(fecha) { 
    id_con_ruta_hoy = rutas_por_dia(fecha).pluck(:id)
    where.not(id: id_con_ruta_hoy)
  }
  # devuelve vehiculos del tipo de carga recibido y con la capacidad necesaria
  scope :por_tipo_y_carga_maxima, ->(tipo_carga, carga_maxima) { 
    where(load_type_id: tipo_carga).where('capacity >= :carga_maxima', carga_maxima: carga_maxima)
  }

  def tiene_conductor?
    self.driver_id.present?
  end
end
