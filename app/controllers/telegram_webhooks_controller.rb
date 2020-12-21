class TelegramWebhooksController < BaseController
  # Common
  def start!(*)
    send_message t(:start)
  end

  def help!(*)
    send_message t(:help)
  end

  def q!(*args)
    if args.any?
      city = City.find_by_name(args)
      send_message city.inspect
    end
  end

  def add!(*args)
    if args.any? && args.size == 2
      city_name, restaurant_name = args
      city = City.find_by_name city_name
      if city.blank?
        reply_message t(:city_miss)
      else
        session[from['id']] = { action: :add, city: city_name, restaurant: restaurant_name}
        reply_message t(:input_restaurant_desc)
      end
      # city, restaurants_name = args.split(/\, /)
    end
  end

  def message(message)
    return if session[from['id']].blank?

    case session[from['id']][:action]
    when :add
      create_restaurant message
    else # type code here
      send_message 'something wrong happened'
    end

  end



  private

  def create_restaurant(message)
    city = City.find_by_name session[from['id']][:city]
    city.restaurants.create(name: session[from['id']][:restaurant], desc: message['text'])
    send_message 'create restaurant successful'
  rescue StandardError => e
    send_message e
  end

end
