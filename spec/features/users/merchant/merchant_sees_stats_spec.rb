require 'rails_helper'

describe  'as a merchant' do
  before :each do
    @merchant = create(:user, role: 1)
    @item_1 = create(:item, user:@merchant, inventory: 1_000)
    @item_2 = create(:item, user:@merchant, inventory: 2_000)
    @item_3 = create(:item, user:@merchant, inventory: 3_000)
    @item_4 = create(:item, user:@merchant, inventory: 500)
    @item_5 = create(:item, user:@merchant, inventory: 200)
    @item_6 = create(:item, user:@merchant, inventory: 100)

    order = create(:completed_order, user_id:@merchant.id)
    create(:fulfilled_order_item,  order:order, item: @item_1, price: 1, quantity: 25)
    create(:fulfilled_order_item,  order:order, item: @item_2, price: 1, quantity: 26)
    create(:fulfilled_order_item,  order:order, item: @item_3, price: 1, quantity: 27)
    create(:fulfilled_order_item,  order:order, item: @item_4, price: 1, quantity: 28)
    create(:fulfilled_order_item,  order:order, item: @item_5, price: 1, quantity: 29)
    create(:fulfilled_order_item,  order:order, item: @item_6, price: 1, quantity: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)
  end
  context 'visits dashboard and sees stastics' do
    it "should display top 5 items sold by quantity on show page" do
      visit dashboard_path
      within "#top-5-items" do
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_3.name)
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_5.name)
        expect(page).to_not have_content(@item_6.name)
      end
    end
    it "should show the total items sold by the merchant" do
      visit dashboard_path
      within "#total-sold" do
        expect(page).to have_content("Total Items Sold: #{@merchant.total_sold}")
      end
      within "#percentage-inventory" do
        expect(page).to have_content("You've Sold #{@merchant.percentage_of_inventory}% of Your Inventory.")
      end
    end
  end
end
