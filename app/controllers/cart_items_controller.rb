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

  def destroy
    empty_cart
    session[:cart] = create_cart.data
    redirect_to cart_path
  end
end
