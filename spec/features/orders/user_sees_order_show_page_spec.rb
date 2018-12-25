require 'rails_helper'

describe  'Order Show Page' do
  it "should show all order information" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    m_1 = create(:user, role: 1)
    o_1 = create(:order, user_id: user.id)
    item_1 = create(:item, price: 1, user_id: m_1.id)
    item_2 = create(:item, price: 2, user_id: m_1.id)
    item_3 = create(:item, price: 4, user_id: m_1.id)
    create(:fulfilled_order_item, order: o_1, item: item_2, price: 2, quantity: 2, created_at: 7.days.ago, updated_at: 2.days.ago)
    create(:order_item, order: o_1, item: item_3, price: 4, quantity: 2, created_at: 7.days.ago, updated_at: 2.days.ago)

    visit profile_path

    click_link "View Order"

    expect(current_path).to eq(profile_order_path(o_1))

    o_1.order_items.each do |order_item|
      expect(page).to have_content("Order Item ID: #{order_item.id}")
      expect(page).to have_content("Order Item Created At: #{order_item.created_at}")
      expect(page).to have_content("Order Item Updated At: #{order_item.updated_at}")
      expect(page).to have_content("Order Item Status: #{order_item.fulfilled? == true ? "fulfilled" : "not fulfilled"}")

      expect(page).to have_content("Item Name: #{order_item.item.name}")
      expect(page).to have_content("Item Description: #{order_item.item.description}")
      expect(page).to have_content("Item Image: #{order_item.item.thumbnail}")
      expect(page).to have_content("Item Quantity: #{order_item.quantity}")
      expect(page).to have_content("Item Price: $#{order_item.price}")
      expect(page).to have_content("Item Subtotal: $#{order_item.subtotal}")


    end
    expect(page).to have_content("Total Item Quantity: #{o_1.quantity_of_order}")
    expect(page).to have_content("Order Grand Total: $#{o_1.grand_total}")
    expect(page).to have_content("Order Status: #{o_1.status}")

    expect(page).to_not have_content("Item Name: #{item_1.name}")
  end
end
