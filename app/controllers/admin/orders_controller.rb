class Admin::OrdersController < Admin::BaseController
  def destroy
    Order.cancel(params[:id])

    flash[:success] = "Order has been cancelled."
    redirect_to admin_user_path(params[:user_id])
  end

  def show
    @order = Order.find(params[:id])
    @quantity_of_order = @order.quantity_of_order
    @grand_total = @order.grand_total
  end
end
