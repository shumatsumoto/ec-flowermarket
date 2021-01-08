class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :number
      t.integer :count
      t.integer :total_price
      
      t.timestamps
    end
  end
end
