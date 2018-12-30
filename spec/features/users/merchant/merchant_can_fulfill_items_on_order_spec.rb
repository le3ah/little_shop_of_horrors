require "rails_helper"

describe "Merchant Order Item Fulfillment" do
  context 'when visiting order show page from dashboard' do
    before :each do
      @m = create(:user, role: 1)
      @i_1 = create(:item, inventory: 4, user: @m)
      @i_2 = create(:item, user: @m)

      @u = create(:user)
      @o = create(:order, user: @u)
      @oi_1 = create(:order_item, order: @o, item: @i_1, quantity: 2)
      @oi_2 = create(:fulfilled_order_item, order: @o, item: @i_2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m)
      visit dashboard_order_path(@o)
    end
    it 'shows button to fulfill order item which redirects back to dashboard_order page' do
      expect(page).to have_button("Fulfill", count: 1)

      click_button "Fulfill"
      expect(current_path).to eq(dashboard_order_path(@o))
    end

    it 'clicking fulfill updates item and show appropriate flash message' do
      click_button "Fulfill"
      @oi_1.reload
      expect(@oi_1.fulfilled).to eq(true)
      expect(page).to have_content("Order Item has been fulfilled!")
    end

    it 'clicking fulfill permanently reduces item inventory by quantity ordered' do
      expect(@i_1.inventory).to eq(4)
      click_button "Fulfill"

      @i_1.reload
      expect(@i_1.inventory).to eq(2)
    end

    it 'shows text indicating an item has already been fulfilled' do
      expect(page).to have_content("Fulfilled")
    end

    it "shows notice instead of fulfill button when quantity ordered exceeds item inventory" do
      m = create(:user, role: 1)
      i = create(:item, inventory: 3, user: m)

      u = create(:user)
      o = create(:order, user: u)
      oi = create(:order_item, order: o, item: i, quantity: 5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(m)
      visit dashboard_order_path(o)

      expect(i.inventory).to be < oi.quantity
      expect(page).to_not have_button("Fulfill")
      expect(page).to have_css("#red-notice")
    end
  end
end
