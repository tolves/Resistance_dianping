class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.belongs_to :restaurant
      t.string :body
      t.integer :commenter
      t.timestamps
    end
  end
end
