require "rails_helper"

describe "Cart Checkout" do
  context "when a registered user with items in cart" do
    before :each do
      m = create(:user, role: 1)
      @u = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u)
      @i_1 = create(:item, user_id: m.id)
      @i_2 = create(:item, user_id: m.id)

      visit item_path(@i_1)
      click_button "Add to Cart"
      visit item_path(@i_2)
      click_button "Add to Cart"

      visit cart_path
    end

    it 'has a button that checkouts cart' do
      expect(page).to have_selector(:link_or_button, "Checkout")
    end

    it 'checking out creates a pending order' do
      click_button "Checkout"

      order = @u.orders.first
      expect(Order.count).to eq(1)
      expect(order.items.count).to eq(2)
      expect(order.status).to eq("pending")
      expect(order.items.first).to eq(@i_1)
      expect(order.items.second).to eq(@i_2)
    end

    it 'checking out redirects to /profile with updated orders' do
      click_button "Checkout"

      expect(current_path).to eq(profile_path)
      order = @u.orders.first

      within "#order-#{order.id}" do
        expect(page).to have_selector(:link_or_button, "View Order ##{order.id}")
        expect(page).to have_content("Created at: #{order.created_at}")
        expect(page).to have_content("Updated at: #{order.updated_at}")
        expect(page).to have_content("Status: #{order.status}")
        expect(page).to have_content("Item Count: #{order.quantity_of_order}")
        expect(page).to have_content("Grand Total: #{order.grand_total}")
      end

      expect(page).to have_content("Order was created!")

      visit profile_order_path(order.id)

      order.order_items.each do |order_item|
        expect(page).to have_content("Order Item ID: #{order_item.id}")
        expect(page).to have_content("Order Item Created At: #{order_item.created_at}")
        expect(page).to have_content("Order Item Updated At: #{order_item.updated_at}")
        expect(page).to have_content("Order Item Status: not fulfilled")
        expect(page).to have_content("Item Name: #{order_item.item.name}")
        expect(page).to have_content("Item Description: #{order_item.item.description}")
        expect(page).to have_content("Item Image: #{order_item.item.thumbnail}")
        expect(page).to have_content("Item Quantity: #{order_item.quantity}")
        expect(page).to have_content("Item Price: $#{order_item.price}")
        expect(page).to have_content("Item Subtotal: $#{order_item.subtotal}")
      end

      expect(page).to have_content("Total Item Quantity: #{order.quantity_of_order}")
      expect(page).to have_content("Order Grand Total: $#{order.grand_total}")
      expect(page).to have_content("Order Status: #{order.status}")
    end

    it 'clears cart on checkout' do
      click_button "Checkout"

      expect(page).to have_content("Shopping Cart (0)")
    end
  end
end
