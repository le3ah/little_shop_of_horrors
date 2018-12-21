class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Party in my plants! You're a new user! 💐 🌝"
      redirect_to profile_path
    else
      flash.keep[:email_error] = "Whoops! Cannot repeat email address! 🥀"
      render :new
    end
  end

  def show
    render_404 unless current_session
    @user = current_session
  end

  def current_session
    current_user || User.find(session[:user_id]) if session[:user_id]
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :password, :email, :address, :city, :state, :zip)
  end

end
