class Profile::OrdersController < ApplicationController
  def index

  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    order = Order.find(params[:id])

    order.status = "cancelled"
    order.save
    OrderItem.return_inventory_for(order.id)
    OrderItem.unfulfill_items_for(order.id)

    flash[:success] = "Order has been cancelled."
    redirect_to profile_path
  end
end
