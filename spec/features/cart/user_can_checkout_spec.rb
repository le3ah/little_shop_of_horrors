require "rails_helper"

describe "Cart Checkout" do
  context "when a registered user with items in cart" do
    before :each do
      m = create(:user, role: 1)
      u = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(u)
      @i_1 = create(:item, user_id: m.id)
      @i_2 = create(:item, user_id: m.id)

      visit item_path(@i)
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

      order = user.orders.first
      expect(Order.count).to eq(1)
      expect(order.items.count).to eq(2)
      expect(order.status).to eq("pending")
      expect(order.items.first).to eq(@i_1)
      expect(order.items.second).to eq(@i_2)
    end

    it 'checking out redirects to /profile with updated orders' do
      
    end
  end
end
