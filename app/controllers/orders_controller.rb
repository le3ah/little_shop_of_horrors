class OrdersController < ApplicationController
  def create
    order = Order.create(user_id: params[:user_id])
    OrderItem.checkout_cart(@cart, order.id)
  end
end
