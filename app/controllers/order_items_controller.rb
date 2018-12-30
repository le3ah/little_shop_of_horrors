class OrderItemsController < ApplicationController
  def fulfill_order_item
    merchant_or_admin?

    order_item = OrderItem.find(params[:order_item_id])
    order_item.fulfilled = true
    order_item.save
    order_item.order.update_status
    flash[:success] = "Order Item has been fulfilled!"

    order_item.item.decrease_inventory(order_item.quantity)
    redirect_to dashboard_order_path(order_item.order)
  end
end
