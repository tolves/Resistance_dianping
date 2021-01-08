class AddCommentsCount < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :comments_count, :integer, default: 0
    Restaurant.all.each do |r|
      Restaurant.reset_counters(r.id, :comments)
    end
  end
end
