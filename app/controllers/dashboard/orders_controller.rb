class Dashboard::OrdersController < Dashboard::BaseController
  def index

  end

  def show
    @order = Order.find(params[:id])
    @customer = @order.user
  end
end
