class Merchant::ItemsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @items = Item.where(user_id: @user.id)
  end
end
