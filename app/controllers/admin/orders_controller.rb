class Admin::OrdersController < Admin::BaseController
  def destroy
    Order.cancel(params[:id])

    flash[:success] = "Order has been cancelled."
    redirect_to profile_path
  end
end
