class Dashboard::OrdersController < Dashboard::BaseController
  def index

  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items_for_merchant(current_user.id)
    @customer = @order.user
  end
end
