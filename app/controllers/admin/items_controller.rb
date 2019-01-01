class Admin::ItemsController < Admin::BaseController
  def index
    @merchant = User.find(params[:merchant_id])
    @items = Item.where(user_id: @merchant.id)
  end

  def new
    @merchant = User.find(params[:merchant_id])
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

  def edit
    @merchant = User.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    update_item(@item, updated_item_params)

    flash[:success] = "You successfully edited that item!"
    redirect_to admin_merchant_items_path(@item.user)
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

    def updated_item_params
      params.require(:item).permit(:name, :description, :price, :thumbnail, :inventory)
    end

    def update_item(item, params)
      params.each do |attribute, value|
        next if value.blank? || item[attribute] == value unless attribute == "thumbnail"
        item[attribute] = value
      end
      item.save
    end
    
end
