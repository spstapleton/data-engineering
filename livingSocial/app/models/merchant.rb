class Merchant < ActiveRecord::Base
  #attr_accessor :name, :address

  has_many :items
  has_many :order_rows
end
