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
user = create(:user)
merchant_1 = create(:user, role: 1)
merchant_2 = create(:user, role: 1)
merchant_3 = create(:user, role: 1)
merchant_4 = create(:user, role: 1)

item_1 = create(:item, user: merchant_1)
