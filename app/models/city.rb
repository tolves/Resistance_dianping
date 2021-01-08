class City < ApplicationRecord
  has_many :restaurants
  has_many :statistics
  scope :changed, -> { where('restaurants_count != 0') }
end
