class Route < ApplicationRecord
  belongs_to :load_type
  belongs_to :vehicle, optional: true
  belongs_to :driver, optional: true

  scope :sin_asignar, -> { where(vehicle_id: nil, driver_id: nil) }
  scope :asignadas, -> { where.not(vehicle_id: nil, driver_id: nil) }
  scope :carga_general, -> { where(load_type_id: LoadType::TC_GENERAL_ID) }
  scope :carga_refrigerada, -> { where(load_type_id: LoadType::TC_REFRIGERADA_ID) }
  scope :por_dia, ->(fecha) { 
    filtro_fecha = { inicio_dia: fecha.beginning_of_day, fin_dia: fecha.end_of_day }
    where('starts_at >= :inicio_dia AND ends_at <= :fin_dia ',filtro_fecha)
  }
  
  def asignada?
    self.vehicle_id.present? && self.driver_id.present?
  end

  def sin_asignar?
    self.vehicle_id.nil? && self.driver_id.nil?
  end
end
