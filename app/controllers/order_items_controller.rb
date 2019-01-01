class OrderItemsController < ApplicationController
  def fulfill_order_item
    merchant_or_admin?

    order_item = OrderItem.find(params[:order_item_id])
    if order_item.item.enough_inventory?(order_item.quantity)
      fulfill_and_update(order_item)
      flash[:success] = "Order Item has been fulfilled!"
    end

    redirect_to dashboard_order_path(order_item.order)
  end

  private

  def fulfill_and_update(order_item)
    order_item.fulfilled = true
    order_item.save
    order_item.order.update_status
    order_item.item.decrease_inventory(order_item.quantity)
  end
end
