class OrdersController < ApplicationController
  def create
    order = Order.create(user_id: params[:user_id])
    OrderItem.checkout_cart(@cart, order.id)
    @cart.clear
    session[:cart] = {}
    flash[:success] = "Order was created!"
    redirect_to profile_path
  end
end
