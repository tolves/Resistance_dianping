class Comment < ApplicationRecord
  belongs_to :restaurant, counter_cache: true
end