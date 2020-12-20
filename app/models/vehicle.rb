class Vehicle < ApplicationRecord
  belongs_to :load_type
  belongs_to :driver, optional: true
end
