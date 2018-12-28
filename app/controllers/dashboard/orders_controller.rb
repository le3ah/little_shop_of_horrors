class Dashboard::OrdersController < ApplicationController
  def index

  end

  def show
    @order = Order.find(params[:id])
    @quantity_of_order = @order.quantity_of_order
    @grand_total = @order.grand_total
  end
end
