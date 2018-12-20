class MerchantsController < ApplicationController
  def index
    @merchants = User.merchants
  end

  def show
    @merchant = current_user || User.find(session[:user_id]) 
  end
  
end
