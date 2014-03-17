class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :filename

      t.timestamps
    end
  end
end
