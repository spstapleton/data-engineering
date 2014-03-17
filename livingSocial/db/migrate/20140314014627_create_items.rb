class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_description
      t.decimal :price
      t.integer :merchant_id

      t.timestamps
    end
    add_index :items, :item_description
    add_index :items, :merchant_id
  end
end
