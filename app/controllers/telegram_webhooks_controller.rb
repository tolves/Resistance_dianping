class TelegramWebhooksController < BaseController
  include Telegram::Bot::UpdatesController::CallbackQueryContext
  include Methods
  include Managers
  include Cities

  before_action :session_destroy, only: [:start!, :city!, :add!, :q!]

  # Commons
  def start!(*)
    respond_with :message, text: t(:available_cities), reply_markup: { inline_keyboard: Cities.keyboard }
  end

  def help!(*)
    respond_with :message, text: t(:help), parse_mode: :MarkdownV2
  end

  def list!(*args)
    raise t(:city_query) if args&.size != 1

    city = City.find_by_name! args
    raise t(:cant_find_city) if city.blank?

    session[:restaurants] = Restaurants.list(city.id)
    respond_with :message, text: t(:recommendation), reply_markup: { inline_keyboard: Restaurants.keyboard(session[:restaurants], page: 0), resize_keyboard: true }
  end

  def add!(city_name, *args)
    raise t(:add_help) if args.blank?

    restaurant_name = args.join(' ')
    city = City.find_by_name! city_name

    save_context :create_restaurant_from_message
    session[:city] = city
    session[:restaurant_name] = restaurant_name
    reply_with :message, text: t(:add_description)
  end

  def create_restaurant_from_message(*description)
    session[:restaurant] = Restaurants.create(session[:city], session[:restaurant_name], description.join(' '), user_name(from))
    save_context :create_link_from_message
    respond_with :message, text: t(:input_dp_link)
    # send confirmation request to admins
    confirm_new_restaurant session[:restaurant], from
  end

  def create_link_from_message(*link)
    exit?
    valid_url?
    Restaurants.update(session[:restaurant], link.join(''))
    respond_with :message, text: t(:add_restaurant_successful)
    session.destroy
  end

  def admin!(*args)
    raise t(:you_are_not_an_admin) unless admin?

    Managers.create args.first
    respond_with :message, text: t(:add_admin_success)
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
    restaurant = city.restaurants.find_by! name: restaurant_name
    city.restaurants.destroy(restaurant)
    respond_with :message, text: t(:delete_restaurant_successful)
  end

  def list_restaurants_callback_query(city_id, *)
    session[:restaurants] = Restaurants.list(city_id)
    respond_with :message, text: t(:recommendation), reply_markup: { inline_keyboard: Restaurants.keyboard(session[:restaurants], page: 0), resize_keyboard: true }
  end

  def edit_restaurants_callback_query(page)
    edit_message :text, text: t(:recommendation), reply_markup: { inline_keyboard: Restaurants.keyboard(session[:restaurants], page: page) }
  end

  def show_comments_callback_query(data, *)
    r_id, page = data.split(/,/)
  end

  def pass_callback_query(r_id, *)
    Restaurant.unscoped.find(r_id).update(confirmation: true)
    answer_callback_query t(:pass_new_confirmation)
  end

  def reject_callback_query(r_id, *)
    Restaurant.unscoped.find(r_id).destroy!
    answer_callback_query t(:reject_new_confirmation)
  end

  def message(message)
    return if session.blank?

    case session[:action]
    when :create_comment
      create_comment message['text']
    end
  end

  # def callback_query(data)
  #   data = JSON.parse data
  #   page = (data['page'].blank? ? 0 : data['page'])
  #   restaurant = Restaurant.unscoped.find(data['restaurant']) unless data['restaurant'].blank?
  #
  #   case data['action']
  #   when 'show_comments'
  #     show_comments restaurant, page
  #   when 'new_comment'
  #     new_comment restaurant, page
  #   when 'markdown_restaurants'
  #     markdown_restaurants page
  #   end
  # end



  private

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
  end

  def markdown_restaurants(page)
    text = "<b>#{t(:list)}</b> \n"
    session[:restaurants].limit(pg_offset).offset(page * pg_offset).each do |r|
      text << "#{r.name.html_safe}: #{r.description.html_safe}. <a href=\"#{r.link}\">链接</a> \n"
    end
    respond_with :message, text: text, parse_mode: :HTML
  end

  #admin

  def confirm_new_restaurant(restaurant, user)
    text = "#{user_name(user)} #{t(:submit_new_restaurant)}: \n"
    text << "#{restaurant.city.name}: \n #{restaurant.name}: #{restaurant.description}"
    Admin.all.each do |admin|
      bot.send_message chat_id: admin.chat_id, text: text, reply_markup: { inline_keyboard: Managers.keyboard(restaurant) , one_time_keyboard: true }
    end
  end


end
