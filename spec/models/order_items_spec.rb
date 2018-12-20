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

    it ".popular_items" do
      u_1 = create(:user)
      m_1 = create(:user, role: 1)
      o_1 = Order.create(status: "pending", user_id: u_1.id)
      i_1 = create(:item, price: 1, user_id: m_1.id)
      i_2 = create(:item, price: 1, user_id: m_1.id)
      i_3 = create(:item, price: 1, user_id: m_1.id)
      i_4 = create(:item, price: 1, user_id: m_1.id)
      i_5 = create(:item, price: 1, user_id: m_1.id)
      i_6 = create(:item, price: 1, user_id: m_1.id)

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
        price: i_2.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_2.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )
      OrderItem.create(
        quantity: 3,
        price: i_3.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_3.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )
      OrderItem.create(
        quantity: 24,
        price: i_4.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_4.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )
      OrderItem.create(
        quantity: 14,
        price: i_5.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_5.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )
      OrderItem.create(
        quantity: 1,
        price: i_6.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_6.id,
        created_at: 10.days.ago,
        updated_at: 1.days.ago
      )

      expect(OrderItem.popular_items(:top, 5)).to eq([i_4, i_5, i_2, i_3, i_1])
      expect(OrderItem.popular_items(:bottom, 5)).to eq([i_6, i_1, i_3, i_2, i_5])
    end
  end
end
