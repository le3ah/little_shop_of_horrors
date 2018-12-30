class MerchantsController < ApplicationController

  before_action :not_today_satan
  skip_before_action :not_today_satan, only: [:index]

  def index
    @merchants = User.merchants
    @top_sellers = User.merchants_by_revenue(:top, 3)
    @fast_merchants = User.merchants_by_fullfillment_time(:top, 3)
    @slow_merchants = User.merchants_by_fullfillment_time(:bottom, 3)
    @top_states = User.top_states(3)
    @top_cities = User.top_cities(3)
    @top_orders = Order.top_by_quantity(3) if Order.any_complete?
  end

  def show
    @merchant = current_user || User.find(session[:user_id])
    @top_5 = @merchant.top_5 if @merchant.orders
    @pending_orders = @merchant.pending_orders if @merchant.orders
  end

  def admin_or_merchant
    current_user.role == "merchant" || current_user.role == "admin"
  end

  def not_today_satan
    render_404 unless current_merchant?
  end
end
