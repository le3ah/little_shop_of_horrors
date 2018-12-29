class Admin::MerchantsController < Admin::BaseController
  def index
      @merchants = User.where('role = 1')
  end

  def show
    @user = User.find(params[:id])
    redirect_to admin_user_path(params[:id]) if @user.default?
  end

  def toggle_status
    toggle_enabled(params[:user_id])
    redirect_to admin_merchants_path
  end

  def toggle_role
    user = User.find(params[:id])
    user.toggle_role
    user.reload
    if user.role == "default"
      flash[:success] = "Merchant is now a default user"
      redirect_to admin_user_path(user)
    else
      flash[:success] = "User has been updgraded to Merchant"
      redirect_to admin_merchant_path(user)
    end
  end

end
