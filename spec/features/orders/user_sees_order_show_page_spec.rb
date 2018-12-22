require 'rails_helper'

describe  'Order Show Page' do
  it "should show all order information" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    m_1 = create(:user, role: 1)
    o_1 = create(:completed_order, user_id: user.id)
    item_2 = create(:item, price: 2, user_id: m_1.id)
    order_item = create(:fulfilled_order_item, order: o_1, item: item_2, price: 2, quantity: 2)

    visit profile_path

    click_link "View Order"

    expect(current_path).to eq("/profile/orders/#{o_1.id}")


  end
end
