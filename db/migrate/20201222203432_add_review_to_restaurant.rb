class AddReviewToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :confirmation, :boolean, default: false
  end
end
