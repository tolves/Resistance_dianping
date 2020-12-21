class BaseController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  use_session!

  private

  def referrer_name
    from['first_name'] || from['user_name']
  end

  def send_message(text)
    respond_with :message, text: text
  end
end