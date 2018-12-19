require 'rails_helper'

describe  'Items Show Page' do
  before :each do
    merchant_1 = create(:user, role: 1)
    @item_1 = merchant_1.items.create(
      name: 'Flower Pot',
      description: 'Messy Pot',
      thumbnail: 'thumbnail',
      price: 4,
      inventory: 5,
      enabled: true
    )

    visit item_path(@item_1)
  end
  context 'as any kind of user' do
    it "should show all item information" do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.description)
      expect(page).to have_content(@item_1.thumbnail)
      expect(page).to have_content(@item_1.user.name)
      expect(page).to have_content(@item_1.inventory)
      expect(page).to have_content(@item_1.price)
      expect(page).to have_content("Average Fulfillment Time: #{OrderItem.avg_fulfillment_time(@item_1)}")
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
