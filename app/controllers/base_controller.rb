require 'uri'
class BaseController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  use_session!

  I18n.locale = :zh

  private

  def tolves
    75708608
  end

  def user_name(user)
    user['user_name'].blank? ? full_name(user) : "@#{user['user_name']}"
  end

  def full_name(user)
    "#{user['first_name']} #{user['last_name']}"
  end

  def pg_offset
    15
  end

  def clean_session
    session[from['id']] = nil
    puts "#{from['id']}: session has been cleaned"
  end

  def valid_url?(url)
    uri = URI.parse(url)
    puts url.match(%r{^(https?)://[^\s/$.?#].[^\s]*$})
    uri.is_a?(URI::HTTP) && !uri.host.nil? && url.match(%r{^(https?)://[^\s/$.?#].[^\s]*$})
  rescue URI::InvalidURIError
    false
  end
end