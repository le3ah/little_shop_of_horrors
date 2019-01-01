require 'rails_helper'

describe Cart do
  describe 'instance methods' do
    before(:each) do
      @user = create(:user)
      @item = create(:item, user_id: @user.id, inventory: 3, price: 10)
      @input_data = Hash.new(0)
      @input_data[@item.id.to_s] = 2
      @cart = Cart.new(@input_data)
    end

    it '#items returns an array of CartItems' do
      expect(@cart.items.first).to be_a_kind_of(CartItem)
    end

    it '#items_quantity returns number of total items in cart' do
      expect(@cart.items_quantity).to eq(2)
      item_2 = create(:item, user_id: @user.id, inventory: 3)
      @cart.add_item(item_2)
      expect(@cart.items_quantity).to eq(3)
      @cart.add_item(@item)
      expect(@cart.items_quantity).to eq(4)
      @cart.add_item(@item)
      expect(@cart.items_quantity).to eq(5)
    end
    
    it '#data returns a hash of the item id and quantity' do
      expect(@cart.data).to eq({@item.id.to_s => 2})
    end
    
    it '#grand_total gives grand total of all items' do
      item_2 = create(:item, user_id: @user.id, inventory: 3, price: 10)
      item_3 = create(:item, user_id: @user.id, inventory: 3, price: 10)
      @cart.add_item(item_2)
      @cart.add_item(item_3)

      total = @cart.grand_total

      expect(total).to eq(40)
    end

    it '#add_item updates data when an item is added ' do
       cart = Cart.new(nil)

       cart.add_item(@item)
       expect(cart.data).to eq({@item.id.to_s => 1})

       cart.add_item(@item)
       expect(cart.data).to eq({@item.id.to_s => 2})
    end

    it "#update_item updates data by decrementing" do
      expect(@cart.data).to eq({@item.id.to_s => 2})

      @cart.update_item(@item.id, false)
      expect(@cart.data).to eq({@item.id.to_s => 1})
    end

    it "#update_item updates data by incrementing" do
      expect(@cart.data).to eq({@item.id.to_s => 2})

      @cart.update_item(@item.id, true)
      expect(@cart.data).to eq({@item.id.to_s => 3})
    end

    it "#update_item removes item from data when quantity is 0" do
      expect(@cart.data).to eq({@item.id.to_s => 2})

      @cart.update_item(@item.id, false)
      @cart.update_item(@item.id, false)
      expect(@cart.data).to eq({})
    end

    it '#enough_inventory? returns false if cart item quantity == item inventory' do
      expect(@item.inventory).to eq(3)
      cart = Cart.new({@item.id.to_s => 3})

      expect(cart.enough_inventory_for_more?(@item.id)).to eq(false)
    end

    it "#enough_inventory? returns true if cart item quantity < item inventory" do
      expect(@item.inventory).to eq(3)
      cart = Cart.new({@item.id.to_s => 2})

      expect(cart.enough_inventory_for_more?(@item.id)).to eq(true)
    end

    it '#clear emptys the cart' do
      expect(@cart.data).to eq({@item.id.to_s => 2})
      
      @cart.clear
      
      expect(@cart.data).to eq({})
    end
  end
end
