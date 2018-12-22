require "rails_helper"

describe Order, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
  end

  describe 'Class Methods' do
    it '.top_by_quantity' do
      u = create(:user)
      m = create(:user, role: 1)

      o_1 = Order.create(status: "complete", user_id: u.id)
      o_2 = Order.create(status: "complete", user_id: u.id)
      o_3 = Order.create(status: "complete", user_id: u.id)
      o_4 = Order.create(status: "complete", user_id: u.id)

      i = create(:item, user_id: m.id)
      i_2 = create(:item, user_id: m.id)

      OrderItem.create(
        quantity: 1,
        price: i.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i.id
      )
      OrderItem.create(
        quantity: 1,
        price: i_2.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_2.id
      )

      OrderItem.create(
        quantity: 2,
        price: i.price,
        fulfilled: true,
        order_id: o_2.id,
        item_id: i.id
      )
      OrderItem.create(
        quantity: 2,
        price: i_2.price,
        fulfilled: true,
        order_id: o_2.id,
        item_id: i_2.id
      )

      OrderItem.create(
        quantity: 3,
        price: i.price,
        fulfilled: true,
        order_id: o_3.id,
        item_id: i.id
      )
      OrderItem.create(
        quantity: 3,
        price: i_2.price,
        fulfilled: true,
        order_id: o_3.id,
        item_id: i_2.id
      )

      OrderItem.create(
        quantity: 4,
        price: i.price,
        fulfilled: true,
        order_id: o_4.id,
        item_id: i.id
      )
      OrderItem.create(
        quantity: 4,
        price: i_2.price,
        fulfilled: true,
        order_id: o_4.id,
        item_id: i_2.id
      )

      top_orders = Order.top_by_quantity(3)

      expect(top_orders[0].total_quantity).to eq(8)
      expect(top_orders[1].total_quantity).to eq(6)
      expect(top_orders[2].total_quantity).to eq(4)
    end

    it '.any_complete? - true' do
      u = create(:user)

      o_1 = create(:completed_order, user_id: u.id)
      o_2 = create(:order, user_id: u.id)
      o_3 = create(:order, user_id: u.id)
      o_4 = create(:order, user_id: u.id)

      expect(Order.any_complete?).to eq(true)
    end

    it '.any_complete? - false' do
      u = create(:user)

      o_1 = create(:order, status: "pending", user_id: u.id)
      o_2 = create(:order, status: "pending", user_id: u.id)
      o_3 = create(:order, status: "pending", user_id: u.id)
      o_4 = create(:order, status: "pending", user_id: u.id)

      expect(Order.any_complete?).to eq(false)
    end
  end
  describe  'instance methods' do
    it "#quantity_of_order" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      m_1 = create(:user, role: 1)
      o_1 = create(:order, user_id: user.id)
      item_2 = create(:item, price: 2, user_id: m_1.id)
      item_3 = create(:item, price: 4, user_id: m_1.id)
      create(:fulfilled_order_item, order: o_1, item: item_2, price: 2, quantity: 2, created_at: 7.days.ago, updated_at: 2.days.ago)
      create(:order_item, order: o_1, item: item_3, price: 4, quantity: 2, created_at: 7.days.ago, updated_at: 2.days.ago)

      expect(o_1.quantity_of_order).to eq(4)
    end
    it "#grand_total" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      m_1 = create(:user, role: 1)
      o_1 = create(:order, user_id: user.id)
      item_2 = create(:item, price: 2, user_id: m_1.id)
      item_3 = create(:item, price: 4, user_id: m_1.id)
      create(:fulfilled_order_item, order: o_1, item: item_2, price: 2, quantity: 2, created_at: 7.days.ago, updated_at: 2.days.ago)
      create(:order_item, order: o_1, item: item_3, price: 4, quantity: 2, created_at: 7.days.ago, updated_at: 2.days.ago)

      expect(o_1.grand_total).to eq(12)
    end
  end
end
