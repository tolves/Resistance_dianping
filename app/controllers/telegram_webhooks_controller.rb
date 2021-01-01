class TelegramWebhooksController < BaseController
  before_action :session_destroy, only: [:start!, :city!, :add!, :q!]

  # Commons
  def start!(*)
    kb = city_keyboard
    respond_with :message, text: t(:availible_cities), reply_markup: { inline_keyboard: kb }
  end

  def help!(*)
    respond_with :message, text: t(:help), parse_mode: :MarkdownV2
  end

  def city!(*args)
    return reply_with :message, text: t(:city_query) if args&.size != 1

    city = City.find_by_name! args
    return reply_with :message, text: t(:cant_find_city) if city.blank?

    list_restaurants city.id, 0
  rescue StandardError => e
    respond_with :message, text: e
  end

  def add!(*args)
    return reply_with :message, text: t(:add_help) if args&.size != 2

    city_name, restaurant_name = args
    city = City.find_by_name! city_name
    session[:action] = :description
    session[:city] = city_name
    session[:restaurant] = restaurant_name
    reply_with :message, text: t(:add_description)
  rescue StandardError => e
    respond_with :message, text: e
  end

  def admin!(*args)
    return unless admins

    Admin.create(chat_id: args)
    respond_with :message, text: t(:add_admin_success)
  rescue StandardError => e
    respond_with :message, text: e
  end

  def q!(*args)
    keywords = args.join('_')
    restaurants = Restaurant.search keywords
    return respond_with :message, text: t(:cant_find_restaurants) if restaurants.blank?

    session[:restaurants] = restaurants
    kb = restaurants_keyboard 0
    respond_with :message, text: keywords, reply_markup: { inline_keyboard: kb, resize_keyboard: true }
  end

  def mitsui!(*)
    respond_with :message, text: t(:happy_new_year)
    bot.send_message chat_id: tolves, text: "#{from.inspect} send /mitsui to bot"
  end

  def delete!(*args)
    return unless admins

    city_name, restaurant_name = args
    city = City.find_by_name! city_name
    restaurant = city.restaurants.where(name: restaurant_name)
    city.restaurants.destroy(restaurant)
    respond_with :message, text: t(:delete_restaurant_successful)
  rescue StandardError => e
    respond_with :message, text: e
  end

  def message(message)
    return if session.blank?

    if message['text'] == 'exit'
      respond_with :message, text: t(:exit)
      session_destroy
    end

    case session[:action]
    when :description
      create_restaurant message['text']
    when :dp_link
      dp_link message['text']
    when :create_comment
      create_comment message['text']
    end

  rescue StandardError => e
    respond_with :message, text: e
  end

  def callback_query(data)
    data = JSON.parse data
    page = (data['page'].blank? ? 0 : data['page'])
    restaurant = Restaurant.unscoped.find(data['restaurant']) unless data['restaurant'].blank?

    case data['action']
    when 'show_comments'
      show_comments restaurant, page
    when 'new_comment'
      new_comment restaurant, page
    when 'edit_restaurants'
      edit_restaurants page
    when 'list_restaurants'
      list_restaurants data['city_id'], page
    when 'confirmation_pass'
      confirmation_pass restaurant
    when 'confirmation_reject'
      confirmation_reject restaurant
    when 'markdown_restaurants'
      markdown_restaurants page
    end
  rescue StandardError => e
    respond_with :message, text: e
  end



  private

  #new_restaurant
  def create_restaurant(text)
    city = City.find_by_name session[:city]
    restaurant = city.restaurants.create(name: session[:restaurant], description: text, author: user_name(from), confirmation: false)
    respond_with :message, text: t(:input_dp_link)

    # send confirmation request to admins
    confirm_new_restaurant restaurant, from
    session[:action] = :dp_link
    session[:restaurant] = restaurant
  rescue StandardError => e
    respond_with :message, text: e
  end

  #add link of the new restaurant
  def dp_link(text)
    restaurant = session[:restaurant]
    return respond_with(:message, text: t(:url_validation_failed)) unless valid_url?(text)

    restaurant.update(dp_link: text)
    respond_with :message, text: t(:add_restaurant_successful)
    session.destroy
  rescue StandardError => e
    respond_with :message, text: e
  end

  #comments
  def show_comments(restaurant, page)
    kb = comments_keyboard restaurant, page
    comments = "<a href=\"#{restaurant.link}\">#{restaurant.city.name} - #{restaurant.name.html_safe}</a> \n"
    comments << "#{restaurant.description.html_safe} \n"
    if restaurant.comments.exists?
      restaurant.comments.each { |c| comments << "#{c.commenter}: #{c.body} (#{c.updated_at.to_s}) \n" }
    else
      comments << t(:no_comments)
    end
    respond_with :message, text: comments, reply_markup: { inline_keyboard: kb }, parse_mode: :HTML
  end

  def comments_keyboard(restaurant, page)
    [[{ text: t(:new_comment), callback_data: ActiveSupport::JSON.encode({ action: 'new_comment', restaurant: restaurant.id, page: page }) }, { text: t(:back_restaurants), callback_data: ActiveSupport::JSON.encode({ action: 'edit_restaurants', page: page }) }]]
  end

  def new_comment(restaurant, page)
    session[:action] = :create_comment
    session[:restaurant] = restaurant
    session[:page] = page
    respond_with :message, text: t(:create_comment)
  end

  def create_comment(text)
    restaurant = session[:restaurant]
    restaurant.comments.create(body: text, commenter: user_name(from))
    show_comments restaurant, session[:page]
    session[:action] = nil
  rescue StandardError => e
    respond_with :message, text: e
  end

  def list_restaurants(city_id, page = 0)
    restaurants = City.find(city_id).restaurants
    return respond_with :message, text: "#{City.find(city_id).name} #{t(:doesnt_has_data)}" if restaurants.blank?

    session[:restaurants] = restaurants
    kb = restaurants_keyboard(page)
    respond_with :message, text: t(:recommendation), reply_markup: { inline_keyboard: kb, resize_keyboard: true }
  end

  def edit_restaurants(page = 0)
    kb = restaurants_keyboard(page)
    edit_message :text, text: t(:recommendation), reply_markup: { inline_keyboard: kb }
  end

  def restaurants_keyboard(page)
    kb = session[:restaurants].limit(pg_offset).offset(page * pg_offset).map { |r| [{ text: "#{r.name}: #{r.description}", callback_data: ActiveSupport::JSON.encode({ action: 'show_comments', restaurant: r.id, page: page}) }, { text: t(:link), url: r.link }] }
    kb.push pagination(session[:restaurants], page: page, action: 'edit_restaurants')
    kb.push [{text: t(:forwardable), callback_data: ActiveSupport::JSON.encode({ action: 'markdown_restaurants', page: page})}]
  end

  def markdown_restaurants(page)
    text = "<b>#{t(:list)}</b> \n"
    session[:restaurants].limit(pg_offset).offset(page * pg_offset).each do |r|
      text << "#{r.name.html_safe}: #{r.description.html_safe}. <a href=\"#{r.link}\">链接</a> \n"
    end
    puts text
    respond_with :message, text: text, parse_mode: :HTML
  end

  def city_keyboard
    city_ids = Restaurant.select(:city_id).group(:city_id)
    available = city_ids.map {|c| { text: c.city.name, callback_data: ActiveSupport::JSON.encode({ action: 'list_restaurants', city_id: c.city_id}) }}
    available.in_groups_of(6, false)
  end

  #admin
  def confirm_new_restaurant(restaurant, user)
    kb = confirmation_keyboard restaurant
    text = "#{user_name(user)} #{t(:submit_new_restaurant)}: \n"
    text << "#{restaurant.city.name}: \n #{restaurant.name}: #{restaurant.description}"
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
