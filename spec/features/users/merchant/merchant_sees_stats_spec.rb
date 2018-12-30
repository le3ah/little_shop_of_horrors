require 'rails_helper'

describe  'as a merchant' do
  context 'visits dashboard and sees stastics' do
    it "should display top 5 items sold by quantity on show page" do
      merchant = create(:user, role: 1)
      item_1 = create(:item, user:merchant)
      item_2 = create(:item, user:merchant)
      item_3 = create(:item, user:merchant)
      item_4 = create(:item, user:merchant)
      item_5 = create(:item, user:merchant)
      item_6 = create(:item, user:merchant)

      order = create(:completed_order, user_id:merchant.id)
      create(:fulfilled_order_item,  order:order, item: item_1, price: 1, quantity: 25)
      create(:fulfilled_order_item,  order:order, item: item_2, price: 1, quantity: 26)
      create(:fulfilled_order_item,  order:order, item: item_3, price: 1, quantity: 27)
      create(:fulfilled_order_item,  order:order, item: item_4, price: 1, quantity: 28)
      create(:fulfilled_order_item,  order:order, item: item_5, price: 1, quantity: 29)
      create(:fulfilled_order_item,  order:order, item: item_6, price: 1, quantity: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_path
      within "#top-5-items" do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_3.name)
        expect(page).to have_content(item_4.name)
        expect(page).to have_content(item_5.name)
        expect(page).to_not have_content(item_6.name)
      end
    end
  end
end
