module Comments
  extend ActiveSupport::Concern
  extend BaseController::Methods
  extend ActionView::Helpers::TranslationHelper


  def self.show(restaurant, page, *)
    comments = "<a href=\"#{restaurant.link}\">#{restaurant.city.name} - #{restaurant.name.html_safe}</a> \n"
    comments << "#{restaurant.description.html_safe} \n"
    if restaurant.comments.exists?
      restaurant.comments.each { |c| comments << "#{c.commenter}: #{c.body} (#{c.updated_at.to_s}) \n" }
    else
      comments << t(:no_comments)
    end
    { text: comments, keyboard: keyboard(restaurant, page) }
  end

  def self.keyboard(restaurant, page)
    [[{ text: t(:new_comment), callback_data: "new_comment:#{restaurant.id},#{page}"}, { text: t(:back_restaurants), callback_data: "edit_restaurants:#{page}" }]]
  end
end