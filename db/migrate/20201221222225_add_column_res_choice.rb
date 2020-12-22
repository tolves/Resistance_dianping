class AddColumnResChoice < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :res_choice, :string
  end
end
