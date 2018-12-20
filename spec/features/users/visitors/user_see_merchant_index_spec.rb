require "rails_helper"

describe "Merchants Index Page" do
  context 'as a visitor' do
    before :each do
      @merch = create(:user, role: 1, enabled: false)
      @merch_2 = create(:user, role: 1, created_at: 2.days.ago)
      visit merchants_path
    end

    it 'should show merchant information' do
      expect(page).to have_content(@merch_2.name)
      expect(page).to have_content(@merch_2.city)
      expect(page).to have_content(@merch_2.state)
      expect(page).to have_content(@merch_2.created_at)
    end

    it 'should not show inactive merchant information' do
      expect(page).to_not have_content(@merch.name)
      expect(page).to_not have_content(@merch.city)
      expect(page).to_not have_content(@merch.state)
      expect(page).to_not have_content(@merch.created_at)
    end
    describe 'Merchant Statistics' do
      before :each do
        u_1 = create(:user)

        @m_1 = create(:user, role: 1)
        @m_2 = create(:user, role: 1)
        @m_3 = create(:user, role: 1)
        @m_4 = create(:user, role: 1)

        @o_1 = Order.create(status: "pending", user_id: u_1.id)
        @o_2 = Order.create(status: "pending", user_id: u_1.id)
        @o_3 = Order.create(status: "pending", user_id: u_1.id)
        @o_4 = Order.create(status: "pending", user_id: u_1.id)

        @i_1 = create(:item, price: 1, user_id: @m_1.id)
        @i_2 = create(:item, price: 1, user_id: @m_1.id)

        @i_3 = create(:item, price: 5, user_id: @m_2.id)
        @i_4 = create(:item, price: 5, user_id: @m_2.id)

        @i_5 = create(:item, price: 10, user_id: @m_3.id)
        @i_6 = create(:item, price: 10, user_id: @m_3.id)

        @i_7 = create(:item, price: 15, user_id: @m_4.id)
        @i_8 = create(:item, price: 15, user_id: @m_4.id)

        OrderItem.create(
          quantity: 2,
          price: @i_1.price,
          fulfilled: true,
          order_id: @o_1.id,
          item_id: @i_1.id
        )

        OrderItem.create(
          quantity: 10,
          price: @i_2.price,
          fulfilled: false,
          order_id: @o_2.id,
          item_id: @i_2.id
        )

        OrderItem.create(
          quantity: 1,
          price: @i_3.price,
          fulfilled: true,
          order_id: @o_1.id,
          item_id: @i_3.id
        )

        OrderItem.create(
          quantity: 1,
          price: @i_4.price,
          fulfilled: true,
          order_id: @o_2.id,
          item_id: @i_4.id
        )

        OrderItem.create(
          quantity: 1,
          price: @i_5.price,
          fulfilled: true,
          order_id: @o_1.id,
          item_id: @i_5.id
        )

        OrderItem.create(
          quantity: 1,
          price: @i_6.price,
          fulfilled: true,
          order_id: @o_2.id,
          item_id: @i_6.id
        )

        OrderItem.create(
          quantity: 1,
          price: @i_7.price,
          fulfilled: true,
          order_id: @o_1.id,
          item_id: @i_7.id
        )

        OrderItem.create(
          quantity: 1,
          price: @i_8.price,
          fulfilled: true,
          order_id: @o_2.id,
          item_id: @i_8.id
        )

        visit merchants_path
      end

      it 'should show top 3 merchants by items sold price and quantity' do
        sorted = User.merchants_by_revenue(:top, 3)

        expect(all('.revenue-stat')[0]).to have_content(sorted[0].name)
        expect(all('.revenue-stat')[1]).to have_content(sorted[1].name)
        expect(all('.revenue-stat')[2]).to have_content(sorted[2].name)
      end

      it 'should show best 3 merchants by order fulfillment time' do
        sorted = User.merchants_by_fullfillment_time(:top, 3)

        expect(all('.fast-order-stat')[0]).to have_content(sorted[0].name)
        expect(all('.fast-order-stat')[1]).to have_content(sorted[1].name)
        expect(all('.fast-order-stat')[2]).to have_content(sorted[2].name)
      end

      it 'should show worst 3 merchants by order fulfillment time' do
        sorted = User.merchants_by_fullfillment_time(:bottom, 3)

        expect(all('.slow-order-stat')[0]).to have_content(sorted[0].name)
        expect(all('.slow-order-stat')[1]).to have_content(sorted[1].name)
        expect(all('.slow-order-stat')[2]).to have_content(sorted[2].name)
      end

      it 'should show top 3 states where orders are shipped' do

      end

      it 'should show top 3 cities where orders where shipped' do

      end

      it 'should top 3 orders by quantity of items' do

      end
    end
  end
end
