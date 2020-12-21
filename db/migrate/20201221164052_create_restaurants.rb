class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.belongs_to :city
      t.string :name
      t.string :dp_link
      t.text :desc
      t.timestamps
    end
  end
end
