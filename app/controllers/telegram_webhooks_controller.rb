class TelegramWebhooksController < BaseController
  # Common
  def start!(*)
    send_message t(:start)
  end

  def help!(*)
    send_message t(:help)
  end
end
