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
    if thumbnail.class != String
      File.open(Rails.root.join('app', 'assets', 'images', thumbnail.original_filename), 'wb') do |file|
        file.write(thumbnail.read)
      end
    end

    @item = current_user.items.new(item_params)
    if @item.save
      flash[:success] = "Item added!"
      redirect_to dashboard_items_path
    else
      flash[:error] = "Something went wrong!"
      @errors = @item.errors.full_messages
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    update_item(@item, updated_item_params)
    flash[:success] = "You successfully edited that item!"
    redirect_to dashboard_items_path
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:success] = "item successfully deleted!"
    redirect_to dashboard_items_path
  end

  def toggle_item
    item = Item.find(params[:item_id])
    item.toggle_enabled
    item.reload

    flash[:success] = item.enabled? ?
      "Item is available for sale!" :
      "Item is no longer available for sale!"

    redirect_to dashboard_items_path
  end


  private

  def item_params
    if params[:item][:thumbnail].class != String
      thing = params[:item][:thumbnail].original_filename
      params[:item][:thumbnail] = thing
      params.require(:item).permit(:name, :description, :price, :thumbnail, :inventory)
    else
      params[:item][:thumbnail] = "no_img.jpg"
      params.require(:item).permit(:name, :description, :thumbnail, :price, :inventory)
    end
  end

  def updated_item_params
    params.require(:item).permit(:name, :description, :price, :thumbnail, :inventory)
  end

  def update_item(item, params)
    params.each do |attribute, value|
      next if value.blank? || item[attribute] == value unless attribute == "thumbnail"
      item[attribute] = value
    end
    flash_warnings(params)
    item.save
  end

  def flash_warnings(params)
    messages = []
    params.each do |attribute, value|
      if value.blank? && attribute != "thumbnail"
        messages << "#{attribute} cannot be blank. Using previous value."
      end
    end
    flash[:error] = messages
  end
end
