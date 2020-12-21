class Route < ApplicationRecord
  belongs_to :load_type
  belongs_to :vehicle, optional: true
  belongs_to :driver, optional: true

  scope :sin_asignar, -> { where(vehicle_id: nil, driver_id: nil) }
  scope :asignadas, -> { where(vehicle_id: !nil, driver_id: !nil) }
  scope :carga_general, -> { where(load_type_id: LoadType::TC_GENERAL_ID) }
  scope :carga_refrigerada, -> { where(load_type_id: LoadType::TC_REFRIGERADA_ID) }
  
  def asignada?
    self.vehicle_id.present? && self.driver_id.present?
  end

  def sin_asignar?
    self.vehicle_id.nil? && self.driver_id.nil?
  end
end
