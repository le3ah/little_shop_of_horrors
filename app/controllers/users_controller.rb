class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:id] = @user.id
      redirect_to profile_path
    else
      render :new
    end
  end

  def show
    @user = User.find(session[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :password, :email, :address, :city, :state, :zip)
  end
end
