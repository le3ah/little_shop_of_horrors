 class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :power_users
  before_action :create_cart

  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def create_cart
    @cart ||= Cart.new(session[:cart])
  end

  def power_users
    alpha_and_omega = (current_user && current_user.role == "default") || 
    (current_user && current_user.role == 'admin' )  ||
    (current_user && current_user.role == 'merchant')
    alpha_and_omega
  end 

end
