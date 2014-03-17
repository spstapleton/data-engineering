class OrdersController < ApplicationController
  def index
    @error_message = params[:error_message] if params[:error_message]
    @orders = if params[:merchant_id]
                Order.get_orders_for 'merchant', params[:merchant_id]
              elsif params[:customer_id]
                Order.get_orders_for 'customer', params[:customer_id]
              elsif params[:item_id]
                Order.get_orders_for 'item', params[:item_id]
              else
                Order.all
              end
  end

  def show
    @order = Order.find params[:id]
  end

  def new
    if current_user.blank?
      error_message = "You must sign in to import new orders."
      redirect_to(action: 'index', error_message: error_message) and return
    end
  end

  def create
    if current_user.blank?
      error_message = "You must sign in to import new orders."
      redirect_to(action: 'index', error_message: error_message) and return
    end
    line_num = 0
    header_row = []
    order = Order.create filename: params['upload']['datafile'].original_filename
    File.open(params['upload'].andand['datafile'].andand.tempfile, 'r') do |file|

      file.each do |line|
        line_data = line.delete("\n").split("\t")
        if line_num == 0
          line_data.each { |header|
            puts header
            puts convert_header_text_to_sym(header)
            header_row.push convert_header_text_to_sym(header)
          }
        else
          row_data = {order_id: order.id}
          line_data.each_with_index { |data, index| row_data[header_row[index]] = data }
          OrderRow.import_order row_data
        end
        puts "#{line_num} #{line}"
        line_num += 1
      end
    end
    @order = order
    render "show"
  end

  private
  def convert_header_text_to_sym header_text
    case header_text
      when "purchaser name"
        :customer_name
      when "item description"
        :item_description
      when "item price"
        :price
      when "purchase count"
        :purchase_count
      when "merchant address"
        :address
      when "merchant name"
        :merchant_name
    end
  end

end