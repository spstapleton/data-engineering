class OrderRow < ActiveRecord::Base
  # :purchase_count, :order_id, :merchant_id, :customer_id, :item_id

  belongs_to :order
  belongs_to :item
  belongs_to :merchant
  belongs_to :customer

  def self.import_order order_data
    order_row = OrderRow.new
    order_row.order_id = order_data[:order_id]
    order_row.purchase_count = order_data[:purchase_count].gsub(/[^0-9]/,'') .to_i
    merchant = Merchant.where("name = ? AND address = ?", order_data[:merchant_name], order_data[:address]).first
    if merchant.blank?
      merchant = Merchant.create(name: order_data[:merchant_name], address: order_data[:address])

    end
    order_row.merchant_id = merchant.id

    customer = Customer.where("name = ?", order_data[:customer_name]).first
    if customer.blank?
      customer = Customer.create(name: order_data[:customer_name])
    end
    order_row.customer_id = customer.id

    item = Item.where("item_description = ? AND price = ?", order_data[:item_description], order_data[:price].to_f).first
    if item.blank?
      item = Item.create item_description: order_data[:item_description], price: order_data[:price].gsub(/[^0-9\.]/,'').to_f, merchant_id: order_row.merchant_id
    end
    order_row.item_id = item.id
    order_row.save
  end

  def total_cost
    (item.andand.price || 0) * (purchase_count || 0)
  end
end
