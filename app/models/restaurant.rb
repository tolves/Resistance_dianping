class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments, dependent: :destroy

  default_scope { where(confirmation: true) }

  def link
    dp_link.blank? ? "https://www.google.com/search?q=#{self.city.name} #{name}" : dp_link
  end

  def self.search(args)
    self.where("to_tsvector('english', name || ' ' || description) @@ to_tsquery(?)", args)
  end
end
