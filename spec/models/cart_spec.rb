require 'rails_helper'

describe Cart do
  describe 'instance methods' do
    before(:each) do
      user = create(:user)
      @item = create(:item, user_id: user.id, inventory: 2)
      input_data = Hash.new(0)
      input_data[@item.id.to_s] = 2
      @cart = Cart.new(input_data)
    end

    it '#items returns an array of CartItems' do
      expect(@cart.items.first).to be_a_kind_of(CartItem)
    end

    it '#data returns a hash of the item id and quantity' do
      expect(@cart.data).to eq({@item.id.to_s => 2})
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
      expect(@item.inventory).to eq(2)
      expect(@cart.data).to eq({@item.id.to_s => 2})

      expect(@cart.enough_inventory?(@item.id)).to eq(false)
    end

    it "#enough_inventory? returns true if cart item quantity < item inventory" do
      expect(@item.inventory).to eq(2)
      cart = Cart.new({@item.id.to_s => 1})

      expect(cart.enough_inventory?(@item.id)).to eq(true)
    end
  end
end
