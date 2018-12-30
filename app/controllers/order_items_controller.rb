class OrderItemsController < ApplicationController
  def fulfill_order_item
    merchant_or_admin?
    order_item = OrderItem.find(params[:order_item_id])
    order_item.fulfilled = true
    order_item.save
    order_item.order.check_complete
    redirect_to dashboard_order_path(item.order)
  end
end
