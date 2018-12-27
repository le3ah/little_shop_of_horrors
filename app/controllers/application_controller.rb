 class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
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

  def empty_cart
    @cart = Cart.new(nil)
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end
end
