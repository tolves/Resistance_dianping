class City < ApplicationRecord
  has_many :restaurants
  scope :changed, -> { where('restaurants_count != 0') }
end
