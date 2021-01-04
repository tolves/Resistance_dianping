class City < ApplicationRecord
  has_many :restaurants
  scope :unchanged, -> { where('updated_at = created_at') }
end
