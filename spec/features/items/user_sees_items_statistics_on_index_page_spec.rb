require "rails_helper"

describe 'Items Index Page' do

  context 'as any kind of user' do
      it "should show most and least popular items" do
        m_1 = create(:user, role: 1)
        o_1 = Order.create(status: "pending", user_id: m_1.id)

        m_2 = create(:user, role: 1)

        @i_1 = m_1.items.create(
          name: 'Flower Pot',
          description: 'Messy Pot',
          thumbnail: 'thumbnail',
          price: 4,
          inventory: 5,
          enabled: true
        )

        @i_2 = m_2.items.create(
          name: 'Orchid sauce',
          description: 'Juicy sauce',
          thumbnail: 'thumbnail for sauce',
          price: 2,
          inventory: 12,
          enabled: true
        )
        @i_3 = m_1.items.create(
          name: 'Spider Plant',
          description: 'spiderlike',
          thumbnail: 'thumbnail',
          price: 4,
          inventory: 5,
          enabled: true
        )

        @i_4 = m_2.items.create(
          name: 'Apple tree',
          description: 'boring',
          thumbnail: 'thumbnail for sauce',
          price: 2,
          inventory: 12,
          enabled: true
        )
        @i_5 = m_1.items.create(
          name: 'Orange Leaf',
          description: 'Colorful!',
          thumbnail: 'thumbnail',
          price: 4,
          inventory: 5,
          enabled: true
        )

        @i_6 = m_2.items.create(
          name: 'Pods',
          description: 'This is a plant',
          thumbnail: 'thumbnail for sauce',
          price: 2,
          inventory: 12,
          enabled: true
        )
        OrderItem.create(
          quantity: 2,
          price: @i_1.price,
          fulfilled: true,
          order_id: o_1.id,
          item_id: @i_1.id,
          created_at: 10.days.ago,
          updated_at: 1.days.ago
        )
        OrderItem.create(
          quantity: 10,
          price: @i_2.price,
          fulfilled: true,
          order_id: o_1.id,
          item_id: @i_2.id,
          created_at: 10.days.ago,
          updated_at: 1.days.ago
        )
        OrderItem.create(
          quantity: 3,
          price: @i_3.price,
          fulfilled: true,
          order_id: o_1.id,
          item_id: @i_3.id,
          created_at: 10.days.ago,
          updated_at: 1.days.ago
        )
        OrderItem.create(
          quantity: 24,
          price: @i_4.price,
          fulfilled: true,
          order_id: o_1.id,
          item_id: @i_4.id,
          created_at: 10.days.ago,
          updated_at: 1.days.ago
        )
        OrderItem.create(
          quantity: 14,
          price: @i_5.price,
          fulfilled: true,
          order_id: o_1.id,
          item_id: @i_5.id,
          created_at: 10.days.ago,
          updated_at: 1.days.ago
        )
        OrderItem.create(
          quantity: 1,
          price: @i_6.price,
          fulfilled: true,
          order_id: o_1.id,
          item_id: @i_6.id,
          created_at: 10.days.ago,
          updated_at: 1.days.ago
        )

        visit items_path

        sorted_top = Item.popular_items(:top, 5)
        sorted_bottom = Item.popular_items(:bottom, 5)

        expect(all('.most_popular')[0]).to have_content(sorted_top[0].name)
        expect(all('.most_popular')[1]).to have_content(sorted_top[1].name)
        expect(all('.most_popular')[2]).to have_content(sorted_top[2].name)
        expect(all('.most_popular')[3]).to have_content(sorted_top[3].name)
        expect(all('.most_popular')[4]).to have_content(sorted_top[4].name)

        expect(all('.least_popular')[0]).to have_content(sorted_bottom[0].name)
        expect(all('.least_popular')[1]).to have_content(sorted_bottom[1].name)
        expect(all('.least_popular')[2]).to have_content(sorted_bottom[2].name)
        expect(all('.least_popular')[3]).to have_content(sorted_bottom[3].name)
        expect(all('.least_popular')[4]).to have_content(sorted_bottom[4].name)
    end
  end
end
