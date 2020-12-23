class AddIndexFullTextSearch < ActiveRecord::Migration[6.0]
  def change
    rename_column :restaurants, :desc, :description
    add_index :restaurants, "to_tsvector('english', name || ' ' || description)", using: :gin, name: 'restaurants_idx'
  end
end


