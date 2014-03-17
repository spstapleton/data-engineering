class Customer < ActiveRecord::Base
  #attr_accessor :name

  has_many :order_rows
end
