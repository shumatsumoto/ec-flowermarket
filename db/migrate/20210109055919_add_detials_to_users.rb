class AddDetialsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :zipcode, :integer, null: false
    add_column :users, :address, :string, null: false
    add_column :users, :tel, :string, null: false
  end
end
