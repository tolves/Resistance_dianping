module Cities
  extend ActiveSupport::Concern

  def self.keyboard
    city_ids = Restaurant.select(:city_id).group(:city_id)
    available = city_ids.map {|c| { text: c.city.name, callback_data: "list_restaurants:#{c.city_id}" }}
    available.in_groups_of(6, false)
  end
end