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
    render_404 unless current_session && current_user.role == 'default'
    @user = current_session
  end

  def current_session
    current_user || (User.find(session[:user_id]) if session[:user_id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    params[:user].each do |attribute, value|
      next if value.blank? || @user[attribute] == value
      @user[attribute] = value unless attribute =~ /password/
      @user.password = value if attribute =~ /password/
    end
    @user.save
    flash[:success] = "You successfully edited your profile!"
    redirect_to profile_path
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :password, :email, :address, :city, :state, :zip)
  end

end
