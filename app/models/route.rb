class Route < ApplicationRecord
  belongs_to :load_type
  belongs_to :vehicle
  belongs_to :driver
end
