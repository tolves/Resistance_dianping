class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.belongs_to :city
      t.belongs_to :restaurant
      t.integer :views, default: 0
      t.timestamps
    end
  end
end
