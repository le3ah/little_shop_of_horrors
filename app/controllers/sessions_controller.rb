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
    else
      flash.keep[:error] = "Oh no! Something went wrong. 🤯 🥀"
      render :new
    end
  end
end
