module Managers
  extend ActiveSupport::Concern
  extend BaseController::Methods
  extend ActionView::Helpers::TranslationHelper

  def self.create(chat_id)
    raise 'chat_id must be Numeric' unless chat_id.match?(/^\d{10,}/)

    Admin.create(chat_id: chat_id)
  end

  def self.keyboard(restaurant)
    [[{ text: t(:confirmation_pass), callback_data: "pass:#{restaurant.id}"}, { text: t(:confirmation_reject), callback_data: "reject:#{restaurant.id}"}]]
  end
end