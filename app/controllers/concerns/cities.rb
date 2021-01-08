module Cities
  extend ActiveSupport::Concern
  extend BaseController::Methods

  @pg_offset = 6
  @group_size = 6


  def self.keyboard(**args)
    changed = City.changed
    page = args[:page].to_i
    Rails.cache.fetch(":cities/#{changed.size}/#{page}") do
      puts 'update caches'
      cities = Restaurant.select(:city_id).group(:city_id).limit(@pg_offset * @group_size).offset(page * @pg_offset * @group_size).map { |c| { text: c.city.name, callback_data: "list_restaurants:#{c.city_id}" } }
      cities = cities.in_groups_of(@group_size, false)
      pg_size = (changed.size.to_f / @group_size).ceil
      cities.push pagination(pg_size, @pg_offset, page: page, action: 'edit_cities')
    end
  end

end