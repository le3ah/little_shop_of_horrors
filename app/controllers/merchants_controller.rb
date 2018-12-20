class MerchantsController < ApplicationController
  def index
    @merchants = User.merchants
    @top_sellers = User.merchants_by_revenue(:top, 3)
    @fast_merchants = User.merchants_by_fullfillment_time(:top, 3)
    @slow_merchants = User.merchants_by_fullfillment_time(:bottom, 3)
  end

  def show
    @merchant = User.find(session[:user_id])
  end
end
