class Item < ActiveRecord::Base
  #attr_accessor :item_description, :price, :merchant_id

  belongs_to :merchant
  has_many :order_rows
end
