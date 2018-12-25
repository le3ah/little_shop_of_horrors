require "rails_helper"

describe "User Order Cancel" do
  context "as a registered user with a pending order" do
    before :each do
      @u = create(:user)
      @m = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u)

      @i_1 = create(:item, user: @m)
      @i_2 = create(:item, user: @m)

      @o = create(:order, user: @u)
      @c_o = create(:completed_order, user: @u)

      @oi_2 = create(:order_item, order: @o, item: @i_2)
      @oi_3 = create(:fulfilled_order_item, order: @o, item: @i_1)
      @oi_4 = create(:fulfilled_order_item, order: @o, item: @i_2)
    end

    it 'shows button to cancel only pending orders' do
      visit profile_order_path(@o.id)

      expect(page).to have_selector(:link_or_button, "Cancel Order")

      visit profile_order_path(@c_o.id)
      expect(page).to_not have_selector(:link_or_button, "Cancel Order")
    end

    it "changes status of order to 'cancelled' when button is clicked" do
      visit profile_order_path(@o.id)

      click_button "Cancel Order"

      @o.reload
      expect(@o.status).to eq("cancelled")
    end

    it "changes status of order's order items to unfulfilled when button is clicked" do
      visit profile_order_path(@o.id)

      click_button "Cancel Order"

      @o.reload
      @o.order_items.each do |o_i|
        o_i.reload
        expect(o_i.status).to be_falsy
      end
    end

    it "returns item quantities to item inventory when button is clicked" do
      visit profile_order_path(@o.id)

      orders_items_join = OrderItem
        .joins("INNER JOIN items ON order_items.item_id = items.id")
        .order(:id)
        .select("order_items.*, items.*")

      current_inv = orders_items_join
          .where("order_items.fulfilled = true")
          .pluck("items.inventory")

      quantities_ordered = OrderItem
          .where(fulfilled: true)
          .order(:id)
          .pluck(:quantity)

      click_button "Cancel Order"

      OrderItem
        .joins("INNER JOIN items ON order_items.item_id = items.id")
        .order(:id)
        .select("order_items.*, items.*")
      .each_with_index do |o_i, i|
        expect(o_i.inventory).to eq(current_inv[i] + quantities_ordered[i])
      end

      it 'redirects to profile page with flash message' do
        visit profile_order_path(@o.id)

        click_button "Cancel Order"

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("Order has been cancelled.")
      end
    end
  end
end
