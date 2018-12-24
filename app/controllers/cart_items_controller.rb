class CartItemsController < ApplicationController
  def index
    @cart_items = create_cart.items
  end

  def create
    item = Item.find(params[:item_id])
    create_cart.add_item(item)
    session[:cart] = create_cart.data
    flash[:success] = "Item has been added to your cart"
    redirect_to items_path
  end

  def update
    require "pry"; binding.pry
  end

  def destroy
    create_cart
  end
end
