class MerchantsController < ApplicationController

  before_action :not_today_satan
  skip_before_action :not_today_satan, only: [:index]

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
  
  def current_merchant?
    current_user && current_user.merchant?
  end 
  
  def not_today_satan
    render file: "#{Rails.root}/public/404.html", status: :not_found unless current_merchant?
  end 

end
