class MerchantsController < ApplicationController
  def index
    @merchants = User.where('role = 1')
  end

  def show
    @merchant = User.find(session[:user_id])
  end
end
