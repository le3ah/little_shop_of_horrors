require 'rails_helper'

describe  'Items Show Page' do
  before :each do
    m_1 = create(:user, role: 1)
    o_1 = Order.create(status: "pending", user_id: m_1.id)
    @i_1 = m_1.items.create(
      name: 'Flower Pot',
      description: 'Messy Pot',
      thumbnail: 'thumbnail',
      price: 4,
      inventory: 5,
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

    visit item_path(@i_1)
  end
  context 'as any kind of user' do
    it "should show all item information" do
      expect(page).to have_content(@i_1.name)
      expect(page).to have_content(@i_1.description)
      expect(page).to have_content(@i_1.thumbnail)
      expect(page).to have_content(@i_1.user.name)
      expect(page).to have_content(@i_1.inventory)
      expect(page).to have_content(@i_1.price)
      expect(page).to have_content("Average Fulfillment Time: #{OrderItem.avg_fulfillment_time(@i_1)}")
    end
  end
  context 'as a visitor' do
    xit "should see a link to add this item to my cart" do

      expect(page).to have_link("Add Item to My Cart")
    end
  end
  context 'as a regular user' do
    xit "should see a link to add this item to my cart" do

      expect(page).to have_link("Add Item to My Cart")
    end
  end
  context 'as a merchant' do
    xit "should not see a link to add item to cart" do
      expect(page).to_not have_content("Add Item to My Cart")
    end
  end
end
