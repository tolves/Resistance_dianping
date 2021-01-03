class AddColumnAuthorId < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :author_id, :integer
  end
end
