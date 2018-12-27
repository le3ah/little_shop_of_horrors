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
      flash.keep[:error] = @user.errors.full_messages
      render :new
    end
  end

  def show
    render_404 unless current_default
    @user = current_session
  end

  def current_session
    current_user || (User.find(session[:user_id]) if session[:user_id])
  end

  def edit
    render_404 unless current_default
    @user = current_user
  end

  def update
    @user = current_user
    updated = update_user(@user, params[:user])
    if updated
      @user.save
      flash[:success] = "You successfully edited your profile!"
      redirect_to profile_path
    else
      flash[:error] = "That email is already in use, please pick another"
      redirect_to profile_edit_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email, :address, :city, :state, :zip)
  end

  def current_default
    current_session && current_user.role == 'default'
  end

  def update_user(user, params)
    params.each do |attribute, value|
      next if value.blank? || user[attribute] == value

      if attribute =~ /password/
        user.password = value
        return true
      end

      return false if attribute == "email" && User.email_in_use?(value)
      user[attribute] = value
    end
  end
end
