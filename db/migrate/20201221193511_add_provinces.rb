class AddProvinces < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :province, :string
  end
end
