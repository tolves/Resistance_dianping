class Restaurant < ApplicationRecord
  extend ActionView::Helpers::TranslationHelper
  belongs_to :city, touch: true, counter_cache: true
  before_save :fix_counter_cache, if: ->(e) { !e.confirmation? }
  has_many :comments, dependent: :destroy
  has_one :statistic, dependent: :destroy

  default_scope { where(confirmation: true) }
  scope :posts, ->(author_id) { where('author_id = ?', author_id) }
  scope :search, ->(args) { where("to_tsvector('english', name || ' ' || description) @@ to_tsquery(?)", args) }
  validates :dp_link, format: { with: %r{\A\z|\Ahttps?://\S+\.\S{2,}\z}, message: t(:url_validation_failed) }

  def link
    dp_link.blank? ? "https://www.google.com/search?q=#{city.name} #{name}" : dp_link
  end

  def fix_counter_cache
    City.decrement_counter(:restaurants_count, city_id)
  end

  def increment_counter
    City.increment_counter(:restaurants_count, city_id)
  end

  def c_count
    comments_count == 0 ? '' : "(#{comments_count})"
  end

end
