class Order < ActiveRecord::Base
  # :filename

  has_many :order_rows

  def self.get_orders_for(field, id)
    case field
      when 'merchant'
        joins(:order_rows).where("order_rows.merchant_id = ?", id)
      when 'customer'
        joins(:order_rows).where("order_rows.customer_id = ?", id)
      when 'item'
        joins(:order_rows).where("order_rows.item_id = ?", id)
      else
        all
    end.distinct
  end

  def get_order_total
    (order_rows || []).inject(0.00) { |sum, ord| sum + ord.total_cost }
  end
end
