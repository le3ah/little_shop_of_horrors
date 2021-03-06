require 'rails_helper'

describe 'as a merchant'do
  before :each do
    @merchant_1 = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    @user1 = create(:user, name:"user1", state: 'NY', city: "Oakfield")
    @user2 = create(:user, name:"user2", state: 'AL', city: "Cullman")
    @user3 = create(:user, name:"user3", state: 'SC', city: "Oakfield")
    @item1 = create(:item, user:@merchant_1)

    order1 = create(:completed_order, user:@user1)
    order2 = create(:completed_order, user:@user2)
    order3 = create(:completed_order, user:@user3)

    order_item1 = create(:fulfilled_order_item, quantity: 1, item:@item1, order: order1)
    order_item2 = create(:fulfilled_order_item, quantity: 2, item:@item1, order: order2)
    order_item3 = create(:fulfilled_order_item, quantity: 11, item:@item1, order: order3)
  end

  context "sees sales details for users" do
    it "should see top states where merchant shipped items" do
      visit dashboard_path
      top_states = @merchant_1.top_shipment_states
      within "#top-states" do
        expect(page).to have_content(top_states.first.state)
        expect(page).to have_content(top_states.second.state)
        expect(page).to have_content(top_states.last.state)
      end
    end
    it "should see top city states where merchant shipped items" do
      visit dashboard_path
      top_city_states = @merchant_1.top_shipment_city_states
      within "#top-cities" do
        expect(page).to have_content("#{top_city_states.first.city}", "#{top_city_states.first.state}")
        expect(page).to have_content("#{top_city_states.second.city}", "#{top_city_states.second.state}")
        expect(page).to have_content("#{top_city_states.last.city}", "#{top_city_states.last.state}")
      end
    end
    it "should see name of user with most orders from merchant" do
      visit dashboard_path
      expect(page).to have_content("User with the Most Orders: #{@merchant_1.most_user_orders.first.name}")
    end
    it "should see name of user purchasing most total items from merchant" do
      visit dashboard_path
      expect(page).to have_content("User Purchasing the Most Total Items: #{@merchant_1.most_items_ordered.first.name}")
    end
    it "should see top 3 users spending the most money on my items" do
      visit dashboard_path
      top_spenders = @merchant_1.top_user_spenders

      within "#top-3-spenders" do
        expect(page).to have_content(top_spenders.first.name)
        expect(page).to have_content(top_spenders.second.name)
        expect(page).to have_content(top_spenders.last.name)
      end
    end
  end

end
