class CreateOrderRows < ActiveRecord::Migration
  def change
    create_table :order_rows do |t|
      t.integer :order_id
      t.integer :purchase_count
      t.integer :merchant_id
      t.integer :customer_id
      t.integer :item_id

      t.timestamps
    end
  end
end
