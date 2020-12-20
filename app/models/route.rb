class Route < ApplicationRecord
  belongs_to :load_type
  belongs_to :vehicle, optional: true
  belongs_to :driver, optional: true
end
