require 'rails_helper'

describe "As a merchant" do
  context 'When I visit my dashboard' do
    it "sees a link to view my own items" do
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit dashboard_path
      expect(page).to have_link("View My Items")
      click_link "View My Items"

      expect(current_path).to eq('/dashboard/items')
    end
    it "sees pending user orders if any" do
      merchant_1 = create(:user, role: 1)
      merchant_2 = create(:user, role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      user_1 = create(:user)
      user_2 = create(:user)

      item_1 = create(:item, user: merchant_1, enabled: true)
      item_2 = create(:item, user: merchant_2, enabled: true)
      item_3 = create(:item, user: merchant_1, enabled: true)
      item_4 = create(:item, user: merchant_2, enabled: true)

      order_fulfilled = create(:completed_order, user: user_1)
      create(:fulfilled_order_item, order: order_fulfilled, item: item_1, price: 1, quantity: 1)

      order_pending = create(:order, user: user_2)
      create(:order_item, order: order_pending, item: item_2, price: 2, quantity: 1)
      create(:fulfilled_order_item, order: order_pending, item: item_1, price: 2, quantity: 1)

      order_pending_2 = create(:order, user: user_1)
      create(:order_item, order: order_pending_2, item: item_3, price: 3, quantity: 3)
      create(:order_item, order: order_pending_2, item: item_1, price: 1, quantity: 5)
      create(:order_item, order: order_pending_2, item: item_2, price: 2, quantity: 2)

      order_pending_3 = create(:order, user: user_2)
      create(:order_item, order: order_pending, item: item_4, price: 2, quantity: 1)

      visit dashboard_path

      within "#pending-orders" do
        expect(page).to have_link("Order ID: #{order_pending_2.id}")
        expect(page).to_not have_link("Order ID: #{order_pending_3.id}")
        expect(page).to_not have_link("Order ID: #{order_fulfilled.id}")

        within "#pending-#{order_pending.id}" do
          expect(page).to have_link("Order ID: #{order_pending.id}")
          expect(page).to have_content("Date Ordered: #{order_pending.created_at}")
          expect(page).to have_content("Quantity of My Items in Order: #{order_pending.quantity_of_my_items(merchant_1)}")
          expect(page).to have_content("Total Value of My Items: $#{order_pending.value_of_my_items(merchant_1)}")
        end

        click_link "Order ID: #{order_pending.id}"
        expect(current_path).to eq "/dashboard/orders/#{order_pending.id}"
      end
    end
  end
end
