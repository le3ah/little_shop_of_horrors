# require 'rails_helper'
#
# describe  'Order Show Page' do
#   @user_1 = create(:user)
#   merchant_1 = create(:user, role: 1, name: "Bill Murray")
#   o_1 = Order.create(status: "pending", user_id: @user_1.id)
#   item_1 = create(:item, user: merchant_1, name: "Nightmares", description: "Nightmares is a delightful plant for any home.  The leering eyes don’t just appear to follow you around the room, they actually do.", enabled: true)
#   item_2 = create(:item, user: merchant_2, name: "Children's Fingers", description: "Don’t let the name fool you, Children’s Fingers is not a plant for a children.  This plant will draw blood at the slightest graze of a hand; however, the good news is blood is the perfect fertilizer to help this plant grow full and strong.", enabled: true)
#   order_item_1 = create(:order_item, order: order, item: item_1, price: 1, quantity: 1)
#   order_item_2 = create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)
#
#
#   visit profile_path
#
#   click_link "View Order"
#
#   expect(current_path).to eq("/profile/orders/#{@user_1.id}")
#
#   expect(page).to have_content("Order ID: #{o_1.id}")
#   expect(page).to have_content("Order Created At: #{o_1.created_at}")
#   expect(page).to have_content("Order Updated At: #{o_1.updated_at}")
#   expect(page).to have_content("Order Status: #{o_1.status}")
#
#   expect(all('.item_tally')).to have_content(item_1.name)
#   expect(all('.item_tally')).to have_content(item_1.description)
#   expect(all('.item_tally')).to have_content(item_1.thumbnail)
#   expect(all('.item_tally')).to have_content(item_1.quantity)
#   expect(all('.item_tally')).to have_content(item_1.price)
#   expect(all('.item_tally')).to have_content(item_1.subtotal)
#
#   expect(all('.item_tally')).to have_content(item_2.name)
#   expect(all('.item_tally')).to have_content(item_2.description)
#   expect(all('.item_tally')).to have_content(item_2.thumbnail)
#   expect(all('.item_tally')).to have_content(item_2.quantity)
#   expect(all('.item_tally')).to have_content(item_2.price)
#   expect(all('.item_tally')).to have_content(item_2.subtotal)
#
#   # total quantity of items in the whole order
#   # grand total of all items for that order
# end
