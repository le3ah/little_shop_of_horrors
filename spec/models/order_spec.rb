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

      create(:completed_order, user_id: u.id)
      create(:order, user_id: u.id)
      create(:order, user_id: u.id)
      create(:order, user_id: u.id)

      expect(Order.any_complete?).to eq(true)
    end

    it '.any_complete? - false' do
      u = create(:user)

      create(:order, status: "pending", user_id: u.id)
      create(:order, status: "pending", user_id: u.id)
      create(:order, status: "pending", user_id: u.id)
      create(:order, status: "pending", user_id: u.id)

      expect(Order.any_complete?).to eq(false)
    end

    it '.cancel - changes order status, saves, calls order item methods' do
      u = create(:user)
      o = create(:order, user: u)

      expect(o.status).to eq("pending")

      Order.cancel(o.id)
      o.reload
      expect(o.status).to eq("cancelled")
    end
  end

  describe 'instance methods' do
    before :each do
      merchant_1 = create(:user, role: 1)
      merchant_2 = create(:user, role: 1)
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      user_4 = create(:user)

      item_1 = create(:item, user: merchant_1, enabled: true)
      item_2 = create(:item, user: merchant_2, enabled: true)
      item_3 = create(:item, user: merchant_1, enabled: true)
      item_4 = create(:item, user: merchant_2, enabled: true)

      @order_fulfilled = create(:completed_order, user: user_1)
      create(:fulfilled_order_item, order: @order_fulfilled, item: item_1, price: 1, quantity: 1)

      @order_pending = create(:order, user: user_2)
      create(:order_item, order: @order_pending, item: item_2, price: 2, quantity: 1)
      create(:fulfilled_order_item, order: @order_pending, item: item_1, price: 2, quantity: 1)

      @order_pending_2 = create(:order, user: user_3)
      @oi_4 = create(:order_item, order: @order_pending_2, item: item_3, price: 3, quantity: 3)
      @oi_5 = create(:order_item, order: @order_pending_2, item: item_1, price: 1, quantity: 5)
      @oi_6 = create(:order_item, order: @order_pending_2, item: item_2, price: 2, quantity: 2)

      @order_pending_3 = create(:order, user: user_4)
      create(:order_item, order: @order_pending_3, item: item_4, price: 2, quantity: 1)

    end

    it "#quantity_of_order" do
      expect(@order_fulfilled.quantity_of_order).to eq(1)
      expect(@order_pending.quantity_of_order).to eq(2)
      expect(@order_pending_2.quantity_of_order).to eq(10)
      expect(@order_pending_3.quantity_of_order).to eq(1)
    end

    it "#grand_total" do
      expect(@order_fulfilled.grand_total).to eq(1)
      expect(@order_pending.grand_total).to eq(4)
      expect(@order_pending_2.grand_total).to eq(18)
      expect(@order_pending_3.grand_total).to eq(2)
    end

    it "#quantity_of_my_items" do
      merchant_1 = create(:user, role: 1)
      merchant_2 = create(:user, role: 1)
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      user_4 = create(:user)

      item_1 = create(:item, user: merchant_1, enabled: true)
      item_2 = create(:item, user: merchant_2, enabled: true)
      item_3 = create(:item, user: merchant_1, enabled: true)
      item_4 = create(:item, user: merchant_2, enabled: true)

      @order_fulfilled = create(:completed_order, user: user_1)
      create(:fulfilled_order_item, order: @order_fulfilled, item: item_1, price: 1, quantity: 1)

      @order_pending = create(:order, user: user_2)
      create(:order_item, order: @order_pending, item: item_2, price: 2, quantity: 1)
      create(:fulfilled_order_item, order: @order_pending, item: item_1, price: 2, quantity: 1)

      @order_pending_2 = create(:order, user: user_3)
      create(:order_item, order: @order_pending_2, item: item_3, price: 3, quantity: 3)
      create(:order_item, order: @order_pending_2, item: item_1, price: 1, quantity: 5)
      create(:order_item, order: @order_pending_2, item: item_2, price: 2, quantity: 2)

      @order_pending_3 = create(:order, user: user_4)
      create(:order_item, order: @order_pending_3, item: item_4, price: 2, quantity: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      expect(@order_pending.quantity_of_my_items(merchant_1)).to eq(1)
      expect(@order_pending_2.quantity_of_my_items(merchant_1)).to eq(8)
      expect(@order_pending_3.quantity_of_my_items(merchant_1)).to eq(nil)
    end

    it "#value_of_my_items" do
      merchant_1 = create(:user, role: 1)
      merchant_2 = create(:user, role: 1)
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)
      user_4 = create(:user)

      item_1 = create(:item, user: merchant_1, enabled: true)
      item_2 = create(:item, user: merchant_2, enabled: true)
      item_3 = create(:item, user: merchant_1, enabled: true)
      item_4 = create(:item, user: merchant_2, enabled: true)

      @order_fulfilled = create(:completed_order, user: user_1)
      create(:fulfilled_order_item, order: @order_fulfilled, item: item_1, price: 1, quantity: 1)

      @order_pending = create(:order, user: user_2)
      create(:order_item, order: @order_pending, item: item_2, price: 2, quantity: 1)
      create(:fulfilled_order_item, order: @order_pending, item: item_1, price: 2, quantity: 1)

      @order_pending_2 = create(:order, user: user_3)
      create(:order_item, order: @order_pending_2, item: item_3, price: 3, quantity: 3)
      create(:order_item, order: @order_pending_2, item: item_1, price: 1, quantity: 5)
      create(:order_item, order: @order_pending_2, item: item_2, price: 2, quantity: 2)

      @order_pending_3 = create(:order, user: user_4)
      create(:order_item, order: @order_pending_3, item: item_4, price: 2, quantity: 1)

      expect(@order_pending.value_of_my_items(merchant_1)).to eq(2)
      expect(@order_pending_2.value_of_my_items(merchant_1)).to eq(14)
      expect(@order_pending_3.value_of_my_items(merchant_1)).to eq(nil)
    end

    it "#order_items_for_merchant" do
      order_items_for_merch_1 = @order_pending_2.order_items_for_merchant(@merchant_1.id)

      expect(order_items_for_merch_1).to eq([@oi_4, @oi_5])
    end
  end
end
