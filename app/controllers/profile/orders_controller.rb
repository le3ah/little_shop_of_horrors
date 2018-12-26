class Profile::OrdersController < ApplicationController
  def index

  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    Order.cancel(params[:id])

    flash[:success] = "Order has been cancelled."
    redirect_to profile_path
  end
end
