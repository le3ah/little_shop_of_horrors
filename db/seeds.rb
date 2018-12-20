# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "factory_bot_rails"

OrderItem.destroy_all
Item.destroy_all
Order.destroy_all
User.destroy_all

include FactoryBot::Syntax::Methods

user_1 = create(:user, city: 'San Diego', state: 'CA')
user_2 = create(:user, city: 'San Diego', state: 'CA')
user_3 = create(:user, city: 'Denver', state: 'CO')
user_4 = create(:user, city: 'Denver', state: 'CO')
user_9 = create(:user, city: 'Denver', state: 'FL')
user_5 = create(:user, city: 'Miami', state: 'FL')
user_6 = create(:user, city: 'Miami', state: 'FL')
user_7 = create(:user, city: 'Oakland', state: 'CA')
user_8 = create(:user, city: 'New York', state: 'NY')

Order.create(status: "complete", user_id: user_1.id)
Order.create(status: "complete", user_id: user_2.id)
Order.create(status: "complete", user_id: user_3.id)
Order.create(status: "complete", user_id: user_4.id)
Order.create(status: "complete", user_id: user_5.id)
Order.create(status: "complete", user_id: user_6.id)
Order.create(status: "complete", user_id: user_7.id)
Order.create(status: "complete", user_id: user_8.id)
Order.create(status: "complete", user_id: user_9.id)
