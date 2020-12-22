class ChangeColumnCommenterType < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :commenter, :string
  end
end
