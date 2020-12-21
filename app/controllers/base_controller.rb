class BaseController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  use_session!

  private

  def referrer_name
    from['first_name'] || from['user_name']
  end

  def send_message(text)
    set_locale
    respond_with :message, text: text
  end

  def reply_message(text)
    set_locale
    reply_with :message, text: text
  end

  def set_locale
    I18n.locale = locale_code
  end

  def locale_code
    from['language_code'][0..1]
  end

end