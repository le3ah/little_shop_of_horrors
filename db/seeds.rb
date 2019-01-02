# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'factory_bot_rails'

include FactoryBot::Syntax::Methods

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

admin = create(:user, role: 2)
admin_1 = create(:user, role: 2, name: "admin", email: "admin@admin.com", password: "admin")
merchant_5 = create(:user, role: 1, name: "merchant", email: "merchant@merchant.com", password: "merchant")
user = create(:user, name: "user", email: "user@user.com", password: "user")

user_1 = create(:user, name: "Sean", state: "SC", city: "Charleston")
user_2 = create(:user, name: "Jim", state: "NY", city: "Oakfield")
user_3 = create(:user, name: "Kathy", state: "AL", city: "Cullman")
user_4 = create(:user, name: "Ben", state: "TN", city: "Nashville")
user_5 = create(:user, name: "Emily", state: "AL", city: "Birmingham")
user_6 = create(:user, name: "Alice", state: "MO", city: "Springfield")
user_7 = create(:user, name: "Brad", state: "IL", city: "Springfield")
user_8 = create(:user, name: "Amanda", state: "IL", city: "Chicago")
user_9 = create(:user, name: "Guy", state: "AL", city: "Pelham")
user_10 = create(:user, name: "Rudy", state: "IN", city: "South Bend")

merchant_1 = create(:user, role: 1, name: "Bill Murray", email: "bill@bill.com", password: "bill")
merchant_2 = create(:user, role: 1, name: "Steve Martin", email: "steve@steve.com", password: "steve")
merchant_3 = create(:user, role: 1, name: "Rick Moranis", email: "rick@rick.com", password: "rick")
merchant_4 = create(:user, role: 1, name: "Jack Nicholson", email: "jack@jack.com", password: "jack")

item_1 = create(:item, thumbnail: "plant_1", user: merchant_1, name: "Nightmares", description: "Nightmares is a delightful plant for any home.  The leering eyes don’t just appear to follow you around the room, they actually do.", enabled: true)
item_2 = create(:item, thumbnail: "plant_2", user: merchant_2, name: "Children's Fingers", description: "Don’t let the name fool you, Children’s Fingers is not a plant for a children.  This plant will draw blood at the slightest graze of a hand; however, the good news is blood is the perfect fertilizer to help this plant grow full and strong.", enabled: true)
item_3 = create(:item, thumbnail: "plant_3", user: merchant_3, name: "Bavarian Venus Flytrap", description: "The Bavarian Venus Flytrap is our take on the traditional.  Instead of flies, this plant has a taste for small household pets.  Cats, rodents, and annoyingly small dogs, beware.", enabled: true)
item_4 = create(:item, thumbnail: "plant_4", user: merchant_4, name: "Spider Leaf", description: "If shiny objects regularly go missing in your home, blame the Spider Leaf.  Warning, the Spider Leaf has been known to take rings off fingers and the fingers sometimes come off the hand as well.", enabled: true)
item_5 = create(:item, thumbnail: "plant_5", user: merchant_4, name: "Werewolf Rose", description: "Werewolf Rose has a dreamy look to it in the daytime and transforms to its demonic self once the sun goes down.  Post-transformation, this plant emits a nightmarish howling.  Enjoy!", enabled: true)
item_6 = create(:item, thumbnail: "plant_6", user: merchant_4, name: "Albino Rat", description: "The Albino Rat is not an animal; it’s a plant!  For sale!", enabled: true)
item_7 = create(:item, thumbnail: "plant_7", user: merchant_5, name: "Medusa's Monkeys", description: "Medusa’s Monkeys are a poisonous trio and make a great replacement for office ferns.", enabled: true)
item_8 = create(:item, thumbnail: "plant_8", user: merchant_5, name: "Cavities", description: "Cavities are so-called as they’re able to locate the remotest of open spaces, fill them, and rip them to shreds, causing immense pain for all parties involved.", enabled: true)
item_9 = create(:item, thumbnail: "plant_9", user: merchant_5, name: "Giraffe's Neck", description: "The Giraffe’s Neck will wrap around nearby objects and strangle.  Purchase of this plant comes with a knife, just in case.", enabled: true)
item_10 = create(:item, thumbnail: "plant_10", user: merchant_1, name: "Librarian's Tongues", description: "Librarian’s Tongues always come in pairs.  Silent, but deadly.  Keeping them in their cage is entirely appropriate.", enabled: true)
item_11 = create(:item, thumbnail: "plant_11", user: merchant_1, name: "Purple Squealer", description: "The Purple Squealer is one of our more popular options with young people.  It makes a high-pitched cry that only teenagers can hear.  Works as a great a prank against your teacher.", enabled: true)
item_12 = create(:item, thumbnail: "plant_12", user: merchant_1, name: "Pacifier", description: "If a child locks eyes with the Pacifier, it will be hypnotized into a heavy night-terror-filled slumber. Use sparingly.", enabled: true)
item_13 = create(:item, thumbnail: "plant_13", user: merchant_1, name: "Grandmother Longlegs", description: "Grandmother Longlegs is continually sweeping her legs.  Sometimes she’ll graze you as you walk by, and other times, she’ll aggressively throw things across the room. ", enabled: true)
item_14 = create(:item, thumbnail: "plant_14", user: merchant_1, name: "Red Grouch", description: "The Red Grouch regularly spews pollen over the home.  Nothing can be done", enabled: true)
item_15 = create(:item, thumbnail: "plant_15", user: merchant_1, name: "Sunnyflowers", description: "Sunnyflowers appear to be happy, but upon closer inspection, they’re actually quite angry, often screaming in rage for no apparent reason.  A delight for all who come to see!", enabled: true)
item_16 = create(:item, thumbnail: "plant_16", user: merchant_2, name: "Spider Pods", description: "Spider Pods are a perfect additive for the chef in the house.  A few squeezes from the pods will cause upset stomachs all night.  Tasteless and totally undetected!", enabled: true)
item_17 = create(:item, thumbnail: "plant_17", user: merchant_2, name: "Bird Bath", description: "Do you have a problem with too many beautiful birds in your backyard?  The Bird Bath will take care of that!  Visually appealing to our friends in flight, the Bird Bath will lure them in and promptly devour.", enabled: true)
item_18 = create(:item, thumbnail: "plant_18", user: merchant_2, name: "Webbed Cage", description: "The Webbed Cage is a beautifully mysterious plant.  Somehow items lost in the couch years ago will return encased in this gorgeous plant.  Think you can get back your lost item?  Think again.  The webbing will burn any skin it touches.  Exciting!", enabled: true)
item_19 = create(:item, thumbnail: "plant_19", user: merchant_2, name: "Princess's Serpents", description: "The Princess’s Serpents are what we lovingly refer to as a guard-plant.  It knows its owner’s scent and will shoot prickling needles at any intruders to come within 5 feet of the plant.", enabled: true)
item_20 = create(:item, thumbnail: "plant_20", user: merchant_5, name: "Red Skunk Lashes", description: "Red Skunk Lashes are quite beautiful from a distance and can only be viewed in total darkness.  In the daytime, their scent is almost unbearable, but oh what a show for the evening.", enabled: true)
item_21 = create(:item, thumbnail: "plant_21", user: merchant_3, name: "Ghost Pods", description: "Ghost Pods grow best over the graves of household pets. Neat!", enabled: true)
item_22 = create(:item, thumbnail: "plant_22", user: merchant_3, name: "Separated Optical Nerves", description: "Separated Optical Nerves aren’t just fun for your ophthalmology friends; when these pods burst, they’ll cause a burning sensation in your eyes and be so much fun for you as well!", enabled: true)
item_23 = create(:item, thumbnail: "plant_23", user: merchant_3, name: "Tarantula Cactus", description: "Tarantula Cactus needs sunlight and TLC — Toes, Lips, & Carcass.  Don’t worry, those can come from any mammal.", enabled: true)
item_24 = create(:item, thumbnail: "plant_24", user: merchant_3, name: "Cyclops Vine", description: "Too much time spent around the Cyclops Vine may result in your becoming a cyclops too, and really, isn’t that what we all want?", enabled: true)
item_25 = create(:item, thumbnail: "plant_25", user: merchant_3, name: "Fluke", description: "Fluke is our most beautiful, yet boring, creature.  It lazily lounges in the sun and occasionally swats at passersby with its limbs.", enabled: true)
item_26 = create(:item, thumbnail: "plant_26", user: merchant_3, name: "Purple Ducks", description: "Purple Ducks actually quack!  All the time!  No one can make it stop!", enabled: true)
item_27 = create(:item, thumbnail: "plant_27", user: merchant_4, name: "Beetle Pods", description: "Beetle Pods ooze most of the time, and the ooze can be difficult to clean.  If you can catch them on a non-oozey day, count your lucky stars.", enabled: true)
item_28 = create(:item, thumbnail: "plant_28", user: merchant_4, name: "Bursting Succulents", description: "Bursting Succulents make great party favors.  You never know what odor they’ll emit when the pods finally go boom!", enabled: true)
item_29 = create(:item, thumbnail: "plant_29", user: merchant_4, name: "New Jersey Pipecleaner", description: "The New Jersey Pipecleaner is lovely; however, its leaves gather bacteria and save it for an unspecified time, when it chooses to spew its ickiness all around.  15-foot radius in most cases.", enabled: true)
item_30 = create(:item, thumbnail: "plant_30", user: merchant_4, name: "Yellow Eel Tree", description: "The Yellow Eel Tree works best in warmer climates.  A scientific anomaly, it creates an electric shock felt by anyone within 20 yards of the tree, just because.", enabled: true)
# create_list(:item, 10, user: merchant_1, enabled: true)

order_1 = create(:completed_order, user: user_2)
create(:fulfilled_order_item, order: order_1, item: item_1, price: item_1.price, quantity: 1, created_at: 17.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_1, item: item_2, price: item_2.price, quantity: 1, created_at: 71.days.ago, updated_at: 62.days.ago)
create(:fulfilled_order_item, order: order_1, item: item_3, price: item_3.price, quantity: 1, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_1, item: item_4, price: item_4.price, quantity: 1, created_at: 27.days.ago, updated_at: 21.days.ago)
create(:fulfilled_order_item, order: order_1, item: item_5, price: item_5.price, quantity: 9, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_1, item: item_6, price: item_6.price, quantity: 1, created_at: 37.days.ago, updated_at: 20.days.ago)
create(:fulfilled_order_item, order: order_1, item: item_7, price: item_7.price, quantity: 1, created_at: 72.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_1, item: item_8, price: item_8.price, quantity: 1, created_at: 47.days.ago, updated_at: 22.days.ago)
create(:fulfilled_order_item, order: order_1, item: item_9, price: item_9.price, quantity: 2, created_at: 74.days.ago, updated_at: 32.days.ago)

order_2 = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order_2, item: item_10, price: item_10.price, quantity: 1, created_at: 3.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_2, item: item_12, price: item_12.price, quantity: 1, created_at: 2.days.ago, updated_at: 1.days.ago)
create(:fulfilled_order_item, order: order_2, item: item_13, price: item_13.price, quantity: 1, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_2, item: item_14, price: item_14.price, quantity: 2, created_at: 17.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_2, item: item_15, price: item_15.price, quantity: 9, created_at: 20.days.ago, updated_at: 19.days.ago)
create(:fulfilled_order_item, order: order_2, item: item_16, price: item_16.price, quantity: 5, created_at: 15.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_2, item: item_17, price: item_17.price, quantity: 1, created_at: 75.days.ago, updated_at: 52.days.ago)
create(:fulfilled_order_item, order: order_2, item: item_18, price: item_18.price, quantity: 1, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_2, item: item_19, price: item_19.price, quantity: 2, created_at: 7.days.ago, updated_at: 3.days.ago)

order_3 = create(:completed_order, user: user_10)
create(:fulfilled_order_item, order: order_3, item: item_10, price: item_10.price, quantity: 2, created_at: 4.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_3, item: item_12, price: item_12.price, quantity: 1, created_at: 3.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_3, item: item_13, price: item_13.price, quantity: 12, created_at: 17.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_3, item: item_14, price: item_14.price, quantity: 22, created_at: 22.days.ago, updated_at: 21.days.ago)
create(:fulfilled_order_item, order: order_3, item: item_15, price: item_15.price, quantity: 9, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_3, item: item_16, price: item_16.price, quantity: 5, created_at: 34.days.ago, updated_at: 24.days.ago)
create(:fulfilled_order_item, order: order_3, item: item_17, price: item_17.price, quantity: 1, created_at: 47.days.ago, updated_at: 32.days.ago)
create(:fulfilled_order_item, order: order_3, item: item_18, price: item_18.price, quantity: 5, created_at: 47.days.ago, updated_at: 42.days.ago)
create(:fulfilled_order_item, order: order_3, item: item_19, price: item_19.price, quantity: 2, created_at: 57.days.ago, updated_at: 52.days.ago)

order_4 = create(:order, user: user_4)
create(:order_item, order: order_4, item: item_1, price: item_1.price, quantity: 1, created_at: 17.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_4, item: item_2, price: item_2.price, quantity: 1, created_at: 3.days.ago, updated_at: 2.days.ago)

order_5 = create(:order, user: user_8)
create(:order_item, order: order_5, item: item_1, price: item_1.price, quantity: 10, created_at: 6.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_5, item: item_2, price: item_2.price, quantity: 12, created_at: 10.days.ago, updated_at: 9.days.ago)

order_6 = create(:order, user: user_5)
create(:order_item, order: order_6, item: item_1, price: item_1.price, quantity: 1, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_6, item: item_2, price: item_2.price, quantity: 1, created_at: 5.days.ago, updated_at: 3.days.ago)
create(:fulfilled_order_item, order: order_6, item: item_15, price: item_15.price, quantity: 2, created_at: 2.days.ago, updated_at: 1.days.ago)

order_7 = create(:order, user: user_2)
create(:order_item, order: order_7, item: item_20, price: item_20.price, quantity: 1, created_at: 9.days.ago, updated_at: 8.days.ago)
create(:fulfilled_order_item, order: order_7, item: item_21, price: item_21.price, quantity: 1, created_at: 8.days.ago, updated_at: 7.days.ago)

order_8 = create(:order, user: user_9)
create(:order_item, order: order_8, item: item_20, price: item_20.price, quantity: 1, created_at: 16.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_8, item: item_21, price: item_21.price, quantity: 1, created_at: 17.days.ago, updated_at: 12.days.ago)

order_9 = create(:order, user: user_3)
create(:order_item, order: order_9, item: item_22, price: item_22.price, quantity: 1, created_at: 8.days.ago, updated_at: 4.days.ago)
create(:fulfilled_order_item, order: order_9, item: item_23, price: item_23.price, quantity: 1, created_at: 17.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_9, item: item_24, price: item_24.price, quantity: 1, created_at: 13.days.ago, updated_at: 12.days.ago)

order_10 = create(:order, user: user_8)
create(:order_item, order: order_10, item: item_22, price: item_22.price, quantity: 10000, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_10, item: item_23, price: item_23.price, quantity: 1, created_at: 17.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_10, item: item_24, price: item_24.price, quantity: 1, created_at: 14.days.ago, updated_at: 2.days.ago)

order_11 = create(:cancelled_order, user: user_4)
create(:order_item, order: order_11, item: item_11, price: item_11.price, quantity: 1, created_at: 6.days.ago, updated_at: 5.days.ago)
create(:order_item, order: order_11, item: item_3, price: item_3.price, quantity: 1, created_at: 4.days.ago, updated_at: 2.days.ago)

order_12 = create(:cancelled_order, user: user_2)
create(:order_item, order: order_12, item: item_25, price: item_25.price, quantity: 1, created_at: 3.days.ago, updated_at: 2.days.ago)
create(:order_item, order: order_12, item: item_26, price: item_26.price, quantity: 1, created_at: 3.days.ago, updated_at: 2.days.ago)

order_13 = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order_13, item: item_27, price: item_27.price, quantity: 1, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_13, item: item_28, price: item_28.price, quantity: 1, created_at: 7.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_13, item: item_29, price: item_29.price, quantity: 1, created_at: 7.days.ago, updated_at: 2.days.ago)

order_14 = create(:completed_order, user: user_6)
create(:fulfilled_order_item, order: order_14, item: item_27, price: item_27.price, quantity: 10, created_at: 17.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_14, item: item_28, price: item_28.price, quantity: 1, created_at: 17.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_14, item: item_29, price: item_29.price, quantity: 1, created_at: 17.days.ago, updated_at: 2.days.ago)

order_15 = create(:completed_order, user: user_4)
create(:fulfilled_order_item, order: order_15, item: item_1, price: item_1.price, quantity: 1, created_at: 13.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_15, item: item_30, price: item_30.price, quantity: 1, created_at: 11.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_15, item: item_15, price: item_15.price, quantity: 10, created_at: 17.days.ago, updated_at: 12.days.ago)

order_16 = create(:completed_order, user: user_1)
create(:fulfilled_order_item, order: order_16, item: item_1, price: item_1.price, quantity: 1, created_at: 4.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_16, item: item_28, price: item_28.price, quantity: 1, created_at: 17.days.ago, updated_at: 2.days.ago)

order_17 = create(:completed_order, user: user_7)
create(:fulfilled_order_item, order: order_17, item: item_1, price: item_1.price, quantity: 4, created_at: 5.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_17, item: item_28, price: item_28.price, quantity: 5, created_at: 15.days.ago, updated_at: 12.days.ago)

order_18 = create(:completed_order, user: user_2)
create(:fulfilled_order_item, order: order_18, item: item_11, price: item_11.price, quantity: 4, created_at: 12.days.ago, updated_at: 11.days.ago)
create(:fulfilled_order_item, order: order_18, item: item_30, price: item_30.price, quantity: 5, created_at: 7.days.ago, updated_at: 5.days.ago)

order_19 = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order_19, item: item_11, price: item_11.price, quantity: 14, created_at: 4.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_19, item: item_28, price: item_28.price, quantity: 6, created_at: 3.days.ago, updated_at: 2.days.ago)

order_20 = create(:completed_order, user: user_4)
create(:fulfilled_order_item, order: order_20, item: item_11, price: item_11.price, quantity: 6, created_at: 5.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_20, item: item_28, price: item_28.price, quantity: 3, created_at: 8.days.ago, updated_at: 2.days.ago)

order_21 = create(:completed_order, user: user_1)
create(:fulfilled_order_item, order: order_21, item: item_17, price: item_17.price, quantity: 15, created_at: 5.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_21, item: item_28, price: item_28.price, quantity: 12, created_at: 4.days.ago, updated_at: 2.days.ago)

order_22 = create(:completed_order, user: user_7)
create(:fulfilled_order_item, order: order_22, item: item_19, price: item_19.price, quantity: 14, created_at: 15.days.ago, updated_at: 12.days.ago)
create(:fulfilled_order_item, order: order_22, item: item_21, price: item_21.price, quantity: 5, created_at: 5.days.ago, updated_at: 2.days.ago)

order_23 = create(:completed_order, user: user_2)
create(:fulfilled_order_item, order: order_23, item: item_14, price: item_14.price, quantity: 4, created_at: 6.days.ago, updated_at: 3.days.ago)
create(:fulfilled_order_item, order: order_23, item: item_30, price: item_30.price, quantity: 5, created_at: 7.days.ago, updated_at: 3.days.ago)

order_24 = create(:completed_order, user: user_3)
create(:fulfilled_order_item, order: order_24, item: item_26, price: item_26.price, quantity: 14, created_at: 5.days.ago, updated_at: 2.days.ago)
create(:fulfilled_order_item, order: order_24, item: item_22, price: item_22.price, quantity: 6, created_at: 4.days.ago, updated_at: 2.days.ago)

order_25 = create(:completed_order, user: user_9)
create(:fulfilled_order_item, order: order_25, item: item_12, price: item_12.price, quantity: 32, created_at: 15.days.ago, updated_at: 12.days.ago)

order_26 = create(:completed_order, user: user_8)
create(:fulfilled_order_item, order: order_26, item: item_17, price: item_17.price, quantity: 6, created_at: 8.days.ago, updated_at: 4.days.ago)
create(:fulfilled_order_item, order: order_26, item: item_8, price: item_8.price, quantity: 13, created_at: 9.days.ago, updated_at: 3.days.ago)

order_27 = create(:completed_order, user: user_2)
create(:fulfilled_order_item, order: order_27, item: item_9, price: item_9.price, quantity: 3, created_at: 6.days.ago, updated_at: 4.days.ago)

order_28 = create(:completed_order, user: user_10)
create(:fulfilled_order_item, order: order_28, item: item_18, price: item_18.price, quantity: 1, created_at: 11.days.ago, updated_at: 7.days.ago)

order_29 = create(:completed_order, user: user_6)
create(:fulfilled_order_item, order: order_29, item: item_5, price: item_5.price, quantity: 6, created_at: 13.days.ago, updated_at: 6.days.ago)

order_30 = create(:completed_order, user: user_7)
create(:fulfilled_order_item, order: order_30, item: item_2, price: item_2.price, quantity: 25, created_at: 2.days.ago, updated_at: 6.hours.ago)