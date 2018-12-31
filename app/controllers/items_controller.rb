class ItemsController < ApplicationController
  before_action :merchant_or_admin?
  skip_before_action :merchant_or_admin?, only: [:index, :show]

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @average_fulfillment_time = @item.average_fulfillment_time
  end
end
