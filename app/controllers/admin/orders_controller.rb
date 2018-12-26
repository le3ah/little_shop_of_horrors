class Admin::OrdersController < Admin::BaseController
  def destroy
    Order.cancel(params[:id])

    flash[:success] = "Order has been cancelled."
    redirect_to admin_user_path(params[:user_id])
  end
end
