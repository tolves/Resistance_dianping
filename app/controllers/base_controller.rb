require 'uri'

class BaseController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  rescue_from StandardError do |e|
    respond_with :message, text: e
  end

  use_session!

  I18n.locale = :zh



  module Methods

    def admin?
      admin = Admin.find_by_chat_id!(from['id'])
      raise t(:you_are_not_an_admin) unless admin
    end

    def tolves
      75708608
    end

    def user_name(user)
      user['user_name'].blank? ? full_name(user) : user['user_name']
    end

    def full_name(user)
      "#{user['first_name']} #{user['last_name']}"
    end

    def pg_offset
      15
    end

    def session_destroy
      session.destroy
      puts "#{from['id']}: session has been cleaned"
    end

    def valid_url?(url)
      uri = URI.parse(url)
      puts url.match(%r{^(https?)://[^\s/$.?#].[^\s]*$})
      uri.is_a?(URI::HTTP) && !uri.host.nil? && url.match(%r{^(https?)://[^\s/$.?#].[^\s]*$})
    rescue URI::InvalidURIError
      false
    end

    def pagination(resource, **args)
      page_kb = []

      (1 .. ((resource.size - 1) / pg_offset) + 1).each do |p|
        next if p == (args[:page] + 1)

        page_kb.push({ text: p, callback_data: "#{args[:action]}:#{(p - 1)}" })
      end
      page_kb
    end
  end

end