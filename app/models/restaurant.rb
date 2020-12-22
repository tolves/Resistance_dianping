class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments

  scope :confirmation, -> { where(confirmation: true) }
end
