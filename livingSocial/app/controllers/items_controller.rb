class ItemsController < ApplicationController
  def index
    @items = if params[:merchant_id]
               Item.where("merchant_id = ?", params[:merchant_id])
             else
               Item.all
             end
  end
end