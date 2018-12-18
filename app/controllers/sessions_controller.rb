class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Hooray! Welcome! 🎍"
      redirect_to profile_path if user.role == "default"
      redirect_to dashboard_path if user.role == "merchant"
      redirect_to root_path if user.role == "admin"
    else
      flash.keep[:error] = "Oh no! Something went wrong. 🤯 🥀"
      render :new
    end
  end

  def destroy
    session.clear
    
    redirect_to root_path
  end
end
