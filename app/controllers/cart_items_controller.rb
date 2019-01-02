class CartItemsController < ApplicationController
  before_action :visitor_or_default?

  def index
    @cart = create_cart
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
    updated = create_cart.update_item(params[:id], params[:add])
    session[:cart] = create_cart.data
    flash[:success] = "Your cart has been updated" if updated
    flash[:error] = "Not enough item quantity to fulfill that amount" unless updated
    redirect_to cart_path
  end

  def destroy
    empty_cart
    session[:cart] = create_cart.data
    redirect_to cart_path
  end

  def visitor_or_default?
    unless !current_user || (current_user && current_user.role == "default")
      render_404
    end
  end
end
