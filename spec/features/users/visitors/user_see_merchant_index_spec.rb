require "rails_helper"

describe "Merchants Index Page" do
  context 'as a visitor' do
    describe 'Merchant Information' do
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

        within '.revenue-stats' do
          expect(all('.revenue-stat')[0]).to have_content("Merchant: #{sorted[0].name}")
          expect(all('.revenue-stat')[1]).to have_content("Merchant: #{sorted[1].name}")
          expect(all('.revenue-stat')[2]).to have_content("Merchant: #{sorted[2].name}")
        end
      end

      it 'should not included unfulfilled order items in merchant revenue calculations' do
        within '.revenue-stats' do
          expect(page).to_not have_content("Merchant: #{@m_1.name}")
        end
      end

      it 'should show best 3 merchants by order fulfillment time' do
        sorted = User.merchants_by_fullfillment_time(:top, 3)

        within '.fast-order-stats' do
          expect(all('.fast-order-stat')[0]).to have_content("Merchant: #{sorted[0].name}")
          expect(all('.fast-order-stat')[1]).to have_content("Merchant: #{sorted[1].name}")
          expect(all('.fast-order-stat')[2]).to have_content("Merchant: #{sorted[2].name}")
        end
      end

      it 'should show worst 3 merchants by order fulfillment time' do
        sorted = User.merchants_by_fullfillment_time(:bottom, 3)

        within '.slow-order-stats' do
          expect(all('.slow-order-stat')[0]).to have_content("Merchant: #{sorted[0].name}")
          expect(all('.slow-order-stat')[1]).to have_content("Merchant: #{sorted[1].name}")
          expect(all('.slow-order-stat')[2]).to have_content("Merchant: #{sorted[2].name}")
        end
      end

      it 'should show top 3 states where orders are shipped' do
        user_1 = create(:user, city: 'San Diego', state: 'CA')
        user_2 = create(:user, city: 'San Diego', state: 'CA')
        user_3 = create(:user, city: 'Denver', state: 'CO')
        user_4 = create(:user, city: 'Denver', state: 'CO')
        user_5 = create(:user, city: 'Denver', state: 'FL')
        user_6 = create(:user, city: 'Miami', state: 'FL')
        user_7 = create(:user, city: 'Oakland', state: 'CA')
        user_8 = create(:user, city: 'New York', state: 'NY')

        Order.create(status: "complete", user_id: user_1.id)
        Order.create(status: "complete", user_id: user_2.id)
        Order.create(status: "complete", user_id: user_3.id)
        Order.create(status: "complete", user_id: user_4.id)
        Order.create(status: "complete", user_id: user_5.id)
        Order.create(status: "complete", user_id: user_6.id)
        Order.create(status: "complete", user_id: user_7.id)
        Order.create(status: "complete", user_id: user_8.id)

        top_states = User.top_states(3)

        visit merchants_path

        within '.top-states' do
          expect(page).to have_content("State: #{top_states[0].state},")
          expect(page).to have_content("Order Count: #{top_states[0].order_count}")

          expect(page).to have_content("State: #{top_states[1].state},")
          expect(page).to have_content("Order Count: #{top_states[1].order_count}")

          expect(page).to have_content("State: #{top_states[2].state},")
          expect(page).to have_content("Order Count: #{top_states[2].order_count}")
        end
      end

      it 'should show top 3 cities where orders where shipped' do
        within '.top-cities' do
          expect(page).to have_content("City: #{top_states[0].city}, #{top_states[0].state}")
          expect(page).to have_content("Order Count: #{top_states[0].order_count}")

          expect(page).to have_content("City: #{top_states[1].city}, #{top_states[1].state}")
          expect(page).to have_content("Order Count: #{top_states[1].order_count}")

          expect(page).to have_content("City: #{top_states[2].city}, #{top_states[2].state}")
          expect(page).to have_content("Order Count: #{top_states[2].order_count}")
        end
      end

      it 'should top 3 orders by quantity of items' do

      end
    end
  end
end
