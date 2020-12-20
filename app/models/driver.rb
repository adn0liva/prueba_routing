class Driver < ApplicationRecord
  belongs_to :vehicle, optional: true
end
