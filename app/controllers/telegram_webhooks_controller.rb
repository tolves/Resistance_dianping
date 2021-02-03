class TelegramWebhooksController < BaseController
  include Telegram::Bot::UpdatesController::CallbackQueryContext
  include Methods
  include Managers
  include Cities
  include Comments

  before_action :session_destroy, only: %i[start! list! city! add! new! q! i!]
  after_action :session_destroy, only: [:create_link_from_message]

  # /start
  # rake telegram:bot:poller
  def start!(*)
    respond_with :message, text: t(:available_cities), reply_markup: { inline_keyboard: Cities.keyboard(page: 0) }
  end

  def help!(*)
    respond_with :message, text: t(:help), parse_mode: :MarkdownV2
  end

  # /list city_name
  def list!(*args)
    raise t(:city_query) if args&.size != 1

    city = City.find_by_name! args
    session[:restaurants] = Restaurants.list(city.id)
    raise "#{city.name} #{t(:did_not_have_data)}" if session[:restaurants].blank?
    respond_with :message, text: t(:recommendation), reply_markup: { inline_keyboard: Restaurants.keyboard(session[:restaurants], page: 0), resize_keyboard: true }
    statistic(city: city)
  rescue ActiveRecord::RecordNotFound
    raise t(:could_not_find_city)
  end

  # /add city_name restaurant_name
  def add!(*args)
    raise t(:add_help) if args.size < 2

    city_name = args.shift
    restaurant_name = args.join(' ')
    city = City.find_by_name! city_name

    raise t(:restaurant_exists) if city.restaurants.exists? name: restaurant_name

    save_context :create_restaurant_from_message
    session[:city] = city
    session[:restaurant_name] = restaurant_name
    reply_with :message, text: t(:add_description)
  rescue ActiveRecord::RecordNotFound
    raise t(:could_not_find_city)
  end

  # /q keywords
  def q!(*args)
    keywords = args.join('_')
    restaurants = Restaurant.search keywords
    raise t(:cant_find_restaurants) if restaurants.blank?

    session[:restaurants] = restaurants
    respond_with :message, text: keywords, reply_markup: { inline_keyboard: Restaurants.keyboard(session[:restaurants], page: 0), resize_keyboard: true }
  end

  # /i
  def i!(*)
    session[:restaurants] = Restaurant.posts(from['id'])
    respond_with :message, text: t(:my_posts), reply_markup: { inline_keyboard: Restaurants.i(session[:restaurants], page: 0), resize_keyboard: true }
  end

  # /delete city_name restaurant_name
  def delete!(*args)
    raise t(:you_are_not_an_admin) unless admin?

    city_name, restaurant_name = args
    Restaurants.destroy(city_name, restaurant_name)
    respond_with :message, text: t(:delete_restaurant_successful)
  end

  # /admin user_chat_id
  def admin!(*args)
    raise t(:you_are_not_an_admin) unless admin?

    Managers.create args.first
    respond_with :message, text: t(:add_admin_success)
  end

  # /statistic
  def statistic!(*)
    raise t(:you_are_not_an_admin) unless admin?
    results = reports.scan(/.{1,100}/).in_groups_of(70, false)
    results.each do |r|
      respond_with :message, text: r.join("\n")
    end
  end

  # /mitsui
  def mitsui!(*)
    respond_with :message, text: t(:happy_new_year)
    bot.send_message chat_id: tolves, text: "#{from.inspect} send /mitsui to bot"
  end

  # /exec_city city_name province  Add a new city
  def exec_city!(*args)
    raise t(:you_are_not_an_admin) unless admin?

    res = City.find_or_create_by!(name: args[0], province: args[1])
    respond_with :message, text: res.inspect
  end

  # /exec city restaurant link description
  # Add a new restaurant by command
  def exec!(city, restaurant, link, *description)
    raise t(:you_are_not_an_admin) unless admin?

    city = City.find_by_name city
    res = city.restaurants.create!(name: restaurant, description: description.join(' '), dp_link: link)
    respond_with :message, text: res.inspect
  end

  def create_restaurant_from_message(*description)
    session[:restaurant] = Restaurant.create!(city_id: session[:city].id, name: session[:restaurant_name], description: description.join(' '), author: user_name, author_id: from['id'], confirmation: false)
    save_context :create_link_from_message
    respond_with :message, text: t(:input_dp_link)
    # send confirmation request to admins
    confirm_new_restaurant session[:restaurant], from
  end

  def create_link_from_message(*link)
    exit?
    session[:restaurant].update!(dp_link: link.join(''))
    respond_with :message, text: t(:add_restaurant_successful)
  rescue ActiveRecord::RecordInvalid
    save_context :create_link_from_message
    raise t(:url_validation_failed)
  end

  def edit_cities_callback_query(page)
    edit_message :text, text: t(:available_cities), reply_markup: { inline_keyboard: Cities.keyboard(page: page) }
  end

  def list_restaurants_callback_query(city_id, *)
    session[:restaurants] = Restaurants.list city_id
    respond_with :message, text: t(:recommendation), reply_markup: { inline_keyboard: Restaurants.keyboard(session[:restaurants], page: 0), resize_keyboard: true }
    statistic city: City.find(city_id)
  end

  def edit_restaurants_callback_query(page)
    edit_message :text, text: t(:recommendation), reply_markup: { inline_keyboard: Restaurants.keyboard(session[:restaurants], page: page) }
  end

  def show_comments_callback_query(data, *)
    r_id, page, action = data.split(/,/)
    restaurant = Restaurant.find(r_id)
    comments = Comments.show restaurant, page, action
    edit_message :text, text: comments[:text], reply_markup: { inline_keyboard: comments[:keyboard] }, parse_mode: :HTML
    statistic city: restaurant.city, restaurant: restaurant
  end

  def new_comment_callback_query(data, *)
    r_id, page, action = data.split(/,/)
    save_context :create_comment_from_message
    session[:restaurant] = Restaurant.find(r_id)
    session[:page] = page
    session[:action] = action
    respond_with :message, text: t(:create_comment)
  end

  def create_comment_from_message(*comments)
    restaurant = session[:restaurant]
    comment = comments.join(' ')
    restaurant.comments.create(body: comment, commenter: user_name)
    comments = Comments.show restaurant, session[:page], session[:action]
    respond_with :message, text: comments[:text], reply_markup: { inline_keyboard: comments[:keyboard] }, parse_mode: :HTML
    if restaurant.author_id && restaurant.author_id != from['id']
      text = "#{user_name} #{t(:add_new_comment)} #{restaurant.name}:\n#{comment}"
      bot.send_message chat_id: restaurant.author_id, text: text
    end
    session[:action] = nil
  end

  def pass_callback_query(r_id, *)
    r = Restaurant.unscoped.find(r_id)
    r.update!(confirmation: true)
    r.increment_counter
    answer_callback_query t(:pass_new_confirmation)
  end

  def reject_callback_query(r_id, *)
    Restaurant.unscoped.find(r_id).destroy!
    answer_callback_query t(:reject_new_confirmation)
  end

  def output_restaurants_callback_query(page)
    output = Restaurants.output(session[:restaurants], page)
    respond_with :message, text: output, parse_mode: :HTML
  end

  def delete_i_callback_query(data, *)
    r_id, page = data.split(/,/)
    Restaurant.find(r_id).destroy
    answer_callback_query t(:reject_new_confirmation)
    edit_i_callback_query(page)
  end

  def edit_i_callback_query(page)
    edit_message :text, text: t(:my_posts), reply_markup: { inline_keyboard: Restaurants.i(session[:restaurants], page: page) }
  end

  private

  #admin
  def confirm_new_restaurant(restaurant, user)
    text = "#{user_name} #{t(:submit_new_restaurant)}: \n"
    text << "#{restaurant.city.name}: \n#{restaurant.name}: #{restaurant.description}"
    bot.send_message chat_id: Admin.first.chat_id, text: text, reply_markup: { inline_keyboard: Managers.keyboard(restaurant) , one_time_keyboard: true }
  end

  alias city! list!
  alias new! add!
  alias message help!

end
