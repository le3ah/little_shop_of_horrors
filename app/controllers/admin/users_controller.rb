class Admin::UsersController < Admin::BaseController
  def index
    @default_users = User.default
  end

  def show
    @user = User.find(params[:id])
    redirect_to admin_merchant_path(params[:id]) if @user.merchant?
  end

  def edit
    @user = User.find(params[:id])
  end

  def toggle_user
    toggle_enabled(params[:user_id])
    redirect_to admin_users_path
  end
end
