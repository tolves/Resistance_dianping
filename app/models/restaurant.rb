class Restaurant < ApplicationRecord
  extend ActionView::Helpers::TranslationHelper
  belongs_to :city, touch: true
  has_many :comments, dependent: :destroy
  default_scope { where(confirmation: true) }
  scope :posts, ->(author_id) { where('author_id = ?', author_id) }
  validates :dp_link, format: { with: %r{\A\z|\A(https?)://[^\s]+.com/[^\s]*\z}, message: t(:url_validation_failed) }

  def link
    dp_link.blank? ? "https://www.google.com/search?q=#{city.name} #{name}" : dp_link
  end

  def self.search(args)
    where("to_tsvector('english', name || ' ' || description) @@ to_tsquery(?)", args)
  end

end
