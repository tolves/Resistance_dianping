class AddColumnCreater < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :author, :string
  end
end
