class Restaurant < ApplicationRecord
  belongs_to :city
  has_many :comments, dependent: :destroy

  default_scope { where(confirmation: true) }
  scope :posts, ->(author_id) { where('author_id = ?', author_id)}

  def link
    dp_link.blank? ? "https://www.google.com/search?q=#{city.name} #{name}" : dp_link
  end

  def self.search(args)
    where("to_tsvector('english', name || ' ' || description) @@ to_tsquery(?)", args)
  end

end
