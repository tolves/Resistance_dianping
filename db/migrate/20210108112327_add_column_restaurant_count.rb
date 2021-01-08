class AddColumnRestaurantCount < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :restaurants_count, :integer, default: 0
  end
end
