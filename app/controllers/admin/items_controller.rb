class Admin::ItemsController < Admin::BaseController
  def index
    @merchant = User.find(params[:merchant_id])
    @items = Item.where(user_id: @merchant.id)
  end

  def new
    @item = Item.new
  end

  def create
    @merchant = User.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    if @item.save
      flash[:success] = "Item added!"
      redirect_to admin_merchant_items_path(@merchant)
    else
      flash[:error] = @item.errors.full_messages
      render :new
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:success] = "Item successfully deleted!"
    redirect_to admin_merchant_items_path(item.user)
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :price, :thumbnail, :inventory)
    end
end
