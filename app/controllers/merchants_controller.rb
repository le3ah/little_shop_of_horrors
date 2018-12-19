class MerchantsController < ApplicationController
  def index
    @merchants = User.merchants
  end

  def show
    @merchant = User.find(session[:user_id])
  end
end
