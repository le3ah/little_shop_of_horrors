class Admin::UsersController < Admin::BaseController
  def index
    @default_users = User.default
  end

  def show
    @user = User.find(params[:id])
    redirect_to admin_merchant_path(params[:id]) if @user.merchant?
  end

  def toggle_user
    user = User.find(params[:user_id])
    user.switch_enabled
    redirect_to admin_users_path
  end
end
