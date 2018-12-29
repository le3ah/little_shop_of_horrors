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

  def create
    thumbnail = params[:item][:thumbnail]

    File.open(Rails.root.join('app', 'assets', 'images', thumbnail.original_filename), 'wb') do |file|
      file.write(thumbnail.read)
    end

    @merchant = current_user
    @item = @merchant.items.create(item_params)
    redirect_to dashboard_items_path
  end

  def edit
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to dashboard_items_path
  end

  private

  def item_params
    thing = params[:item][:thumbnail].original_filename
    params[:item][:thumbnail] = thing
    params.require(:item).permit(:name, :description, :price, :thumbnail, :inventory)
  end
end
