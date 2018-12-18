class MerchantsController < ApplicationController
  def index
  end

  def show
    @merchant = User.find(session[:user_id])
  end
end
