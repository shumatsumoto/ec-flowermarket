class AddAdminFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin_flag, :boolean, default: false, null: false
  end
end
