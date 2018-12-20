class CartItemsController < ApplicationController
  def index
    @cart_items = cart.items
  end

  def create
    item = Item.find(params[:item_id])   
    cart.add_item(item)
    session[:cart] = cart.data 
    redirect_to items_path
  end
end