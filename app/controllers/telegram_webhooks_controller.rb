class TelegramWebhooksController < BaseController
  # Common
  def start!(*)
    send_message t('telegram.common.start', username: referrer_name)
  end

  def help!(*)
    send_message t('telegram.common.help')
  end
end
