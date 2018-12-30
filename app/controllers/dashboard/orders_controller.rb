class Dashboard::OrdersController < Dashboard::BaseController
  def index

  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items_for_merchant(params[:merchant_id])
    @customer = @order.user
  end
end
