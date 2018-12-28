require 'rails_helper'

describe  'Admin - User Order Show Page' do
  context "when admin visits user's profile" do
    before :each do
      @u = create(:user)
      @a = create(:user, role: 2)
      @o = create(:order, user: @u)

      m = create(:user, role: 1)
      i_1 = create(:item, user: m)
      i_2 = create(:item, user: m)
      create(:order_item, order: @o, item: i_1)
      create(:order_item, order: @o, item: i_2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)
    end

    it 'routes to admin_order_path from admin_user_path link' do
      visit admin_user_path(@u)

      click_link "View Order ##{@o.id}"

      expect(current_path).to eq(admin_order_path(@o))
    end

    it 'shows all order information on admin_order_path' do
      visit admin_order_path(@o)

      expect(page).to have_content("Order ##{@o.id}")
      expect(page).to have_content("Order Created At: #{@o.created_at}")
      expect(page).to have_content("Order Updated At: #{@o.updated_at}")
      expect(page).to have_content("Order Status: #{@o.status}")
      expect(page).to have_content("Total Item Quantity: #{@o.quantity_of_order}")
      expect(page).to have_content("Order Grand Total: #{@o.grand_total}")
      expect(page).to have_button("Cancel Order")

      @o.order_items.each do |order_item|
        expect(page).to have_content("Item Name: #{order_item.item.name}")
        expect(page).to have_content("Item Description: #{order_item.item.description}")
        expect(page).to have_content("Item Image: #{order_item.item.thumbnail}")
        expect(page).to have_content("Item Quantity: #{order_item.quantity}")
        expect(page).to have_content("Item Price: $#{order_item.price}")
        expect(page).to have_content("Item Subtotal: $#{order_item.subtotal}")
      end
    end

    it "has link to cancel order and redirects correctly on admin_order_path" do
      visit admin_order_path(@o)

      click_button "Cancel Order"

      @o.reload
      expect(current_path).to eq(admin_user_path(@u))
      expect(@o.status).to eq("cancelled")
    end
  end
end
