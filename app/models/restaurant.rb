class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments

  default_scope { where(confirmation: true) }

  def link
    dp_link.blank? ? "https://www.google.com/search?q=#{self.city.name} #{name}" : dp_link
  end
end
