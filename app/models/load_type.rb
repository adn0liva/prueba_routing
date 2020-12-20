class LoadType < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  TC_GENERAL_ID = 1
  TC_REFRIGERADA_ID = 2
end
