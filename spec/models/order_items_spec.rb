require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:price)}
    it {should validate_inclusion_of(:fulfilled).in_array([true, false])}
  end

  describe 'relationships' do
    it {should belong_to(:item)}
    it {should belong_to(:order)}
  end

  describe 'class methods' do
    it '.checkout_cart' do
      u = create(:user)
      m = create(:user, role: 1)
      i_1 = create(:item, user: m)
      i_2 = create(:item, user: m)
      o = create(:order, user: u)

      cart = Cart.new({i_1.id.to_s => 3, i_2.id.to_s => 11})
      OrderItem.checkout_cart(cart, o.id)
      created_order_items = o.order_items

      expect(created_order_items.count).to eq(2)

      expect(created_order_items.first.quantity).to eq(cart.data[i_1.id.to_s])
      expect(created_order_items.first.price).to eq(i_1.price)
      expect(created_order_items.first.fulfilled).to be_falsy
      expect(created_order_items.first.order_id).to eq(o.id)
      expect(created_order_items.first.item_id).to eq(i_1.id)

      expect(created_order_items.second.quantity).to eq(cart.data[i_2.id.to_s])
      expect(created_order_items.second.price).to eq(i_2.price)
      expect(created_order_items.second.fulfilled).to be_falsy
      expect(created_order_items.second.order_id).to eq(o.id)
      expect(created_order_items.second.item_id).to eq(i_2.id)
    end

    it '.unfulfill_items_for' do
      u = create(:user)
      m = create(:user, role: 1)

      o = create(:order, user: u)
      i_1 = create(:item, user: m)
      i_2 = create(:item, user: m)

      o_i_1 = create(:fulfilled_order_item, order: o, item: i_1)
      o_i_2 = create(:fulfilled_order_item, order: o, item: i_2)

      OrderItem.unfulfill_items_for(o.id)
      o_i_1.reload
      o_i_2.reload

      expect(o_i_1.fulfilled).to be_falsy
      expect(o_i_2.fulfilled).to be_falsy
    end

    it '.return_inventory_for - adds to item inventory order item quantity' do
      u = create(:user)
      m = create(:user, role: 1)

      o = create(:order, user: u)
      i_1 = create(:item, user: m)
      i_2 = create(:item, user: m)
      i_3 = create(:item, user: m)

      o_i_1 = create(:fulfilled_order_item, order: o, item: i_1)
      o_i_2 = create(:fulfilled_order_item, order: o, item: i_2)
      o_i_3 = create(:order_item, order: o, item: i_3)

      before_inventories = [i_1.inventory, i_2.inventory, i_3.inventory]
      order_items = [o_i_1, o_i_2, o_i_3]

      OrderItem.return_inventory_for(o.id)

      [i_1, i_2, i_3].each {|i| i.reload}

      expect(i_1.inventory).to eq(before_inventories[0] + order_items[0].quantity)
      expect(i_2.inventory).to eq(before_inventories[1] + order_items[1].quantity)
      expect(i_3.inventory).to_not eq(before_inventories[2] + order_items[2].quantity)
    end
  end

  describe  'instance methods' do
    it "#subtotal" do
      u_1 = create(:user)
      m_1 = create(:user, role: 1)
      o_1 = create(:completed_order, user_id: u_1.id)
      item_2 = create(:item, price: 2, user_id: m_1.id)
      order_item = create(:fulfilled_order_item, order: o_1, item: item_2, price: 2, quantity: 2)

      expect(order_item.subtotal).to eq(4)
    end
  end
end
