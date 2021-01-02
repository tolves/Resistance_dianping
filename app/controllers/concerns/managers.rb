module Managers
  extend ActiveSupport::Concern
  extend BaseController::Methods

  def self.create(chat_id)
    raise 'chat_id must be Numeric' unless chat_id.match?(/^\d{7,}/)

    Admin.create(chat_id: chat_id)
  end
end