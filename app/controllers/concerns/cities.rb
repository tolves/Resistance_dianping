module Cities
  extend ActiveSupport::Concern
  extend BaseController::Methods

  @pg_offset = 6
  @group_size = 6


  def self.keyboard(**args)
    unchanged = City.unchanged
    page = args[:page].to_i
    Rails.cache.fetch("#{unchanged.cache_key_with_version}/:cities/#{unchanged.size}/#{page}") do
      puts 'update caches'
      cities = Restaurant.select(:city_id).group(:city_id).limit(@pg_offset * @group_size).offset(page * @pg_offset * @group_size).map { |c| { text: c.city.name, callback_data: "list_restaurants:#{c.city_id}" } }
      cities = cities.in_groups_of(@group_size, false)
      pg_size = Restaurant.group(:city_id).count.size / @group_size
      cities.push pagination(pg_size, @pg_offset, page: page, action: 'edit_cities')
    end
  end

end