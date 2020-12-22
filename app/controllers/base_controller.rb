require 'uri'
class BaseController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  use_session!

  private

  def referrer_name
    from['username'] || from['first_name']
  end

  def respond_with(type, *)
    set_locale
    super
  end

  def set_locale
    I18n.locale = locale_code
  end

  def locale_code
    from['language_code'][0..1]
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