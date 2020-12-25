class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments

  default_scope { where(confirmation: true) }
end
