class TelegramWebhooksController < BaseController
  before_action :clean_session, only: [:city!, :add!]

  # Commons
  def start!(*)
    cities = City.all
    kb = city_keyboard
    respond_with :message, text: t(:availible_cities), reply_markup: { inline_keyboard: kb }
  end

  def help!(*)
    respond_with :message, text: t(:help)
  end

  def city!(*args)
    return reply_with :message, text: t(:city_query) if args&.size != 1

    city = City.find_by_name args
    list_restaurants city.id, 0
  end

  def add!(*args)
    return reply_with :message, text: t(:add_help) if args&.size != 2

    city_name, restaurant_name = args
    city = City.find_by_name city_name
    return t(:cant_find_city) if city.blank?

    session[from['id']] = { action: :desc, city: city_name, restaurant: restaurant_name }
    reply_with :message, text: t(:add_desc)
  end

  def admin!(*args)
    return if from['id'] != 75708608

    Admin.create(chat_id: args)
    respond_with :message, text: t(:add_admin_success)
  rescue StandardError => e
    respond_with :message, text: e
  end

  def message(message)
    return if session[from['id']].blank?

    return session[from['id']] = nil if message['text'] == 'exit'

    case session[from['id']][:action]
    when :desc
      create_restaurant message
    when :dp
      dp_link(message)
    when :create_comment
      create_comment(message)
    end

  rescue StandardError => e
    respond_with :message, text: e
  end

  def callback_query(data)
    data = JSON.parse data
    restaurant = Restaurant.find(data['restaurant']) unless data['restaurant'].blank?

    case data['action']
    when 'show_comments'
      show_comments restaurant, data['page']
    when 'new_comment'
      new_comment restaurant
    when 'show_restaurants'
      show_restaurants data['city_id'], (data['page'].blank? ? 0 : data['page'])
    when 'confirmation_pass'
      confirmation_pass restaurant
    when 'confirmation_reject'
      confirmation_reject restaurant
    end
  rescue StandardError => e
    respond_with :message, text: e
  end



  private

  #new_restaurant
  def create_restaurant(message)
    city = City.find_by_name session[from['id']][:city]
    restaurant = city.restaurants.create(name: session[from['id']][:restaurant], desc: message['text'], author: user_name(from))
    respond_with :message, text: t(:input_dp_link)

    # send confirmation request to admins
    confirm_new_restaurant restaurant, from
    session[from['id']][:action] = :dp
    session[from['id']][:restaurant] = restaurant
  rescue StandardError => e
    respond_with :message, text: e
  end

  def dp_link(message)
    restaurant = session[from['id']][:restaurant]
    puts valid_url?(message['text'])
    return respond_with(:message, text: t(:url_validation_failed)) unless valid_url?(message['text'])

    restaurant.update(dp_link: message['text'])
    respond_with :message, text: t(:add_restaurant_successful)
    session[from['id']] = nil
  rescue StandardError => e
    respond_with :message, text: e
  end

  #comments
  def show_comments(restaurant, page = 0)
    kb = [[{ text: t(:new_comment), callback_data: ActiveSupport::JSON.encode({ action: 'new_comment', restaurant: restaurant.id }) }, { text: t(:back_restaurants), callback_data: ActiveSupport::JSON.encode({ action: 'show_restaurants', restaurant: restaurant.id, city_id: restaurant.city.id, page: page }) }]]
    comments = "#{restaurant.city.name} - #{restaurant.name}: \n"
    comments << "#{restaurant.desc} \n"
    if restaurant.comments.exists?
      restaurant.comments.each { |c| comments << "#{c.commenter}: #{c.body} (#{c.updated_at.to_s}) \n" }
    else comments << t(:no_comments)
    end

    respond_with :message, text: comments, reply_markup: { inline_keyboard: kb }
  end

  def new_comment(restaurant)
    session[from['id']] = { action: :create_comment, restaurant: restaurant }
    respond_with :message, text: t(:create_comment)
  end

  def create_comment(message)
    restaurant = session[from['id']][:restaurant]
    restaurant.comments.create(body: message['text'], commenter: user_name(from))
    show_comments restaurant
    session[from['id']] = nil
  rescue StandardError => e
    respond_with :message, text: e
  end

  def list_restaurants(city_id, page)
    city = City.find(city_id)
    kb = restaurants_keyboard city, page
    respond_with :message, text: "#{city.name} #{t(:recommendation)}", reply_markup: { inline_keyboard: kb, resize_keyboard: true }
  end

  def show_restaurants(city_id, page = 0)
    city = City.find(city_id)
    kb = restaurants_keyboard city, page
    edit_restaurants_list city, kb
  end

  def restaurants_keyboard(city, page)
    restaurants = city.restaurants.confirmation
    kb = restaurants.limit(10).offset( page * 10 ).map { |r| [{ text: "#{r.name}: #{r.desc}", callback_data: ActiveSupport::JSON.encode({ action: 'show_comments', restaurant: r.id, page: page }) }, { text: t(:link), url: (r.dp_link.blank? ? "https://www.google.com/search?q=#{city.name}+#{r.name}" : r.dp_link) }] }
    pages = []
    (1..restaurants.size / 10).each do |p|
      next if p == (page + 1)

      pages.push({ text: p, callback_data: ActiveSupport::JSON.encode({ action: 'show_restaurants', city_id: city.id, page: (p - 1) }) })
    end
    puts pages
    kb.push pages
  end

  def edit_restaurants_list(city, kb)
    edit_message :reply_markup, text: "#{city.name} #{t(:recommendation)}", reply_markup: { inline_keyboard: kb }
  end

  def city_keyboard
    city_ids = Restaurant.select(:city_id).group(:city_id)
    available = city_ids.map {|c| { text: c.city.name, callback_data: ActiveSupport::JSON.encode({ action: 'show_restaurants', city_id: c.city_id}) }}
    available.in_groups_of(6, false)
  end

  #admin
  def confirm_new_restaurant(restaurant, user)
    kb = confirmation_keyboard restaurant
    text = "#{user_name(user)} #{t(:submit_new_restaurant)}: \n"
    text << "#{restaurant.city.name}: \n #{restaurant.name}: #{restaurant.desc}"
    Admin.all.each do |admin|
      bot.send_message chat_id: admin.chat_id, text: text, reply_markup: { inline_keyboard: kb, one_time_keyboard: true }
    end
  end

  def confirmation_keyboard(restaurant)
    [[{ text: t(:confirmation_pass), callback_data: ActiveSupport::JSON.encode({ action: 'confirmation_pass', restaurant: restaurant.id }) }, { text: t(:confirmation_reject), callback_data: ActiveSupport::JSON.encode({ action: 'confirmation_reject', restaurant: restaurant.id }) }]]
  end

  def confirmation_pass(restaurant)
    restaurant.update(confirmation: true)
    answer_callback_query t(:pass_new_confirmation)
  rescue StandardError => e
    respond_with :message, text: e
  end

  def confirmation_reject(restaurant)
    restaurant.destroy!
    answer_callback_query t(:reject_new_confirmation)
  rescue StandardError => e
    respond_with :message, text: e
  end

end
