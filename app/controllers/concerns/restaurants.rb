module Restaurants
  extend ActiveSupport::Concern
  extend BaseController::Methods
  extend ActionView::Helpers::TranslationHelper

  def self.list(city_id, **args)
    city = City.find(city_id)

    Rails.cache.fetch("#{city.cache_key_with_version}/restaurants") do
      City.find(city_id).restaurants
    end
  end

  def self.keyboard(restaurants, **args)
    page = args[:page].to_i

    Rails.cache.fetch("#{restaurants.cache_key_with_version}/#{page}") do
      puts 'update keyboard caches'
      kb = restaurants.limit(pg_offset).offset(page * pg_offset).map { |r| [{ text: "#{r.name}: #{r.description}", callback_data: "show_comments:#{r.id},#{page},edit_restaurants" }, { text: t(:link), url: r.link }] }
      kb.push pagination(restaurants.size, page: page, action: 'edit_restaurants')
      kb.push [{text: t(:forwardable), callback_data: "output_restaurants:#{page}"}]
    end
  end

  def self.i(restaurants, **args)
    page = args[:page].to_i
    kb = restaurants.limit(pg_offset).offset(page * pg_offset).map { |r| [{ text: "#{r.city.name}: #{r.name}", callback_data: "show_comments:#{r.id},#{page},edit_i" }, { text: t(:delete), callback_data: "delete_i:#{r.id},#{page}" }] }
    kb.push pagination(restaurants.size, page: page, action: 'edit_i')
  end

  def self.output(restaurant, page)
    text = "<b>#{t(:list)}</b> \n"
    restaurant.limit(pg_offset).offset(page.to_i * pg_offset).each do |r|
      text << "#{r.name.html_safe}: #{r.description.html_safe}. <a href=\"#{r.link}\">链接</a> \n"
    end
    text
  end

  def self.destroy(city_name, restaurant_name)
    city = City.find_by_name! city_name
    restaurant = city.restaurants.find_by! name: restaurant_name
    city.restaurants.destroy(restaurant)
  end

end