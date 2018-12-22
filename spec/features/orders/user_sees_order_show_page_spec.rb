require 'rails_helper'

describe  'Order Show Page' do
  it "should show all order information" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    m_1 = create(:user, role: 1)
    o_1 = create(:completed_order, user_id: user.id)
    item_2 = create(:item, price: 2, user_id: m_1.id)
    order_item = create(:fulfilled_order_item, order: o_1, item: item_2, price: 2, quantity: 2, created_at: 7.days.ago, updated_at: 2.days.ago)

    visit profile_path

    click_link "View Order"

    expect(current_path).to eq("/profile/orders/#{o_1.id}")

    o_1.order_items.each do |orderitem|
      expect(page).to have_content("Order ID: #{orderitem.id}")
      expect(page).to have_content("Order Created At: #{orderitem.created_at}")
      expect(page).to have_content("Order Updated At: #{orderitem.updated_at}")
      expect(page).to have_content("Order Item Status: #{order_item.fulfilled? == true ? "fulfilled" : "not fulfilled"}")
    end
    expect(page).to have_content("Order Status: #{o_1.status}")
  end
end
