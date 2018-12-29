class Dashboard::ItemsController < Dashboard::BaseController
  def index
    @user = User.find(current_user.id)
    @items = Item.where(user_id: @user.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  
end
