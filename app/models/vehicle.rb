class Vehicle < ApplicationRecord
  belongs_to :load_type
  belongs_to :driver, optional: true
  has_many :routes

end
