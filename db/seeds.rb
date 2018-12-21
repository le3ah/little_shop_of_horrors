# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

admin = create(:user, role: 2)
admin_1 = create(:user, role: 2, name: "admin", email: "admin@admin.com", password: "admin")
merchant_5 = create(:user, role: 1, name: "merchant", email: "merchant@merchant.com", password: "merchant")
user_1 = create(:user, name: "user", email: "user@user.com", password: "user")
user = create(:user)
merchant_1 = create(:user, role: 1)
merchant_2 = create(:user, role: 1)
merchant_3 = create(:user, role: 1)
merchant_4 = create(:user, role: 1)

item_1 = create(:item, user: merchant_1)
item_2 = create(:item, user: merchant_2)
item_3 = create(:item, user: merchant_3)
item_4 = create(:item, user: merchant_4)
item_5 = create(:item, user: merchant_4)
item_6 = create(:item, user: merchant_4)
item_7 = create(:item, user: merchant_5)
create_list(:item, 10, user: merchant_1, enabled: true)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_3, price: 3, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_4, price: 4, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_5, price: 4, quantity: 9)
create(:fulfilled_order_item, order: order, item: item_6, price: 4, quantity: 15)
create(:fulfilled_order_item, order: order, item: item_7, price: 7, quantity: 13)

order = create(:order, user: user)
create(:order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)

order = create(:cancelled_order, user: user)
create(:order_item, order: order, item: item_2, price: 2, quantity: 1)
create(:order_item, order: order, item: item_3, price: 3, quantity: 1)

order = create(:completed_order, user: user)
create(:fulfilled_order_item, order: order, item: item_1, price: 1, quantity: 1)
create(:fulfilled_order_item, order: order, item: item_2, price: 2, quantity: 1)
>>>>>>> 7024f43f5eb117509f0ea0255cde1a679224e0da
