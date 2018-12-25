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
    it '.avg_fulfillment_time' do
      u_1 = create(:user)

      m_1 = create(:user, role: 1)
      o_1 = Order.create(status: "pending", user_id: u_1.id)
      o_2 = Order.create(status: "pending", user_id: u_1.id)
      i_1 = create(:item, price: 1, user_id: m_1.id)

      OrderItem.create(
        quantity: 2,
        price: i_1.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_1.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )

      OrderItem.create(
        quantity: 10,
        price: i_1.price,
        fulfilled: true,
        order_id: o_2.id,
        item_id: i_1.id,
        created_at: 5.days.ago,
        updated_at: 2.days.ago
      )

      expect(OrderItem.avg_fulfillment_time(i_1)).to eq(6)
    end

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
