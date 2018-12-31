require 'rails_helper'

describe 'as a merchant'do
  before :each do
    @merchant_1 = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_1)

    @user1 = create(:user, name:"user1", state: 'NY', city: "Oakfield")
    @user2 = create(:user, name:"user2", state: 'AL', city: "Cullman")
    @user3 = create(:user, name:"user3", state: 'SC', city: "Charleston")
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
      expect(page).to have_content(top_states.first.state)
      expect(page).to have_content(top_states.second.state)
      expect(page).to have_content(top_states.last.state)
    end
  end
end
