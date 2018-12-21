class MerchantsController < ApplicationController
  def index
    @merchants = User.merchants
  end

  def show
    if current_user 
      @merchant = current_user || User.find(session[:user_id]) 
    else 
      not_today_satan
    end
  end

  def not_today_satan
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end 
  
end
