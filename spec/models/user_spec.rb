require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many(:orders) }
    it { should have_many(:items) }
  end

  describe 'should require all fields' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:state) }
    it { should validate_inclusion_of(:enabled).in_array([true, false])}
  end

  describe 'should require uniqueness of' do
      it { should validate_uniqueness_of(:email) }
  end

  describe 'class methods' do
    it '.top_states' do
      user_1 = create(:user, city: 'San Diego', state: 'CA')
      user_2 = create(:user, city: 'San Diego', state: 'CA')
      user_3 = create(:user, city: 'Denver', state: 'CO')
      user_4 = create(:user, city: 'Denver', state: 'CO')
      user_5 = create(:user, city: 'Denver', state: 'FL')
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

      top_s = User.top_states(3)

      expect(top_s[0].state).to eq("CA")
      expect(top_s[0].order_count).to eq(3)

      expect(top_s[1].state).to eq("CO")
      expect(top_s[1].order_count).to eq(2)

      expect(top_s[2].state).to eq("FL")
      expect(top_s[2].order_count).to eq(2)
    end

    it '.top_cities' do
      user_1 = create(:user, city: 'San Diego', state: 'CA')
      user_2 = create(:user, city: 'San Diego', state: 'CA')
      user_3 = create(:user, city: 'Denver', state: 'CO')
      user_4 = create(:user, city: 'Denver', state: 'CO')
      user_5 = create(:user, city: 'Denver', state: 'FL')
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

      top_s = User.top_cities(3)

      expect(top_s[0].city).to eq("Denver")
      expect(top_s[0].order_count).to eq(2)

      expect(top_s[1].city).to eq("San Diego")
      expect(top_s[1].order_count).to eq(2)

      expect(top_s[2].city).to eq("Denver")
      expect(top_s[2].state).to eq("FL")
      expect(top_s[2].order_count).to eq(1)
    end

    it '.merchants - find merchant users' do
      m = create(:user)
      u = create(:user, role: 1)

      users = User.merchants

      expect(users).to include(u)
      expect(users).to_not include(m)
    end

    it '.merchants_by_revenue' do
      u_1 = create(:user)

      m_1 = create(:user, role: 1)
      m_2 = create(:user, role: 1)
      m_3 = create(:user, role: 1)

      o_1 = Order.create(status: "pending", user_id: u_1.id)
      o_2 = Order.create(status: "pending", user_id: u_1.id)

      i_1 = create(:item, price: 1, user_id: m_1.id)
      i_2 = create(:item, price: 1, user_id: m_1.id)

      i_3 = create(:item, price: 5, user_id: m_2.id)
      i_4 = create(:item, price: 5, user_id: m_2.id)

      i_5 = create(:item, price: 10, user_id: m_3.id)
      i_6 = create(:item, price: 10, user_id: m_3.id)

      OrderItem.create(
        quantity: 2,
        price: i_1.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_1.id
      )

      OrderItem.create(
        quantity: 10,
        price: i_2.price,
        fulfilled: false,
        order_id: o_2.id,
        item_id: i_2.id
      )

      OrderItem.create(
        quantity: 1,
        price: i_3.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_3.id
      )

      OrderItem.create(
        quantity: 1,
        price: i_4.price,
        fulfilled: true,
        order_id: o_2.id,
        item_id: i_4.id
      )

      OrderItem.create(
        quantity: 1,
        price: i_5.price,
        fulfilled: true,
        order_id: o_1.id,
        item_id: i_5.id
      )

      OrderItem.create(
        quantity: 1,
        price: i_6.price,
        fulfilled: true,
        order_id: o_2.id,
        item_id: i_6.id
      )

      top_sorted = User.merchants_by_revenue(:top, 3)
      bottom_sorted = User.merchants_by_revenue(:bottom, 3)

      expect(top_sorted).to eq([m_3, m_2, m_1])
      expect(bottom_sorted).to eq([m_1, m_2, m_3])
    end

    it '.switch_enabled - toggles user enabled status' do
      m = create(:user)

      m.switch_enabled

      expect(m.enabled).to eq(false)

      m.switch_enabled

      expect(m.enabled).to eq(true)
    end

    it '.email_in_use?' do
      user1 = create(:user, email: "j@gmail.com")

      expect(User.email_in_use?(user1.email)).to be_truthy
      expect(User.email_in_use?("latin_lover@hotmail.com")).to be_falsy
    end

    it 'default class method finds all of the default users' do
      user1 = create(:user)
      user2 = create(:user)
      merchant = create(:user, role: 1)

      defaults = User.default
      expect(defaults.size).to eq(2)
      expect(defaults.first.id).to eq(user1.id)
      expect(defaults.second.id).to eq(user2.id)
    end

    it 'can switch roles between default and merchant' do
      dude = create(:user)

      dude.toggle_role

      expect(dude.role).to eq("merchant")

      dude.toggle_role

      expect(dude.role).to eq("default")
    end
  end

  describe  'instance methods'do
    it "#pending_orders" do
      merchant_1 = create(:user, role: 1)
      merchant_2 = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

      user_1 = create(:user)
      user_2 = create(:user)

      item_1 = create(:item, user: merchant_1, enabled: true)
      item_2 = create(:item, user: merchant_2, enabled: true)
      item_3 = create(:item, user: merchant_1, enabled: true)
      item_4 = create(:item, user: merchant_2, enabled: true)

      order_fulfilled = create(:completed_order, user: user_1)
      create(:fulfilled_order_item, order: order_fulfilled, item: item_1, price: 1, quantity: 1)

      order_pending = create(:order, user: user_2)
      order_item_2 = create(:order_item, order: order_pending, item: item_2, price: 2, quantity: 1)
      order_item_3 = create(:fulfilled_order_item, order: order_pending, item: item_1, price: 2, quantity: 1)

      order_pending_2 = create(:order, user: user_1)
      create(:order_item, order: order_pending_2, item: item_3, price: 3, quantity: 3)
      create(:order_item, order: order_pending_2, item: item_1, price: 1, quantity: 5)
      create(:order_item, order: order_pending_2, item: item_2, price: 2, quantity: 2)

      order_pending_3 = create(:order, user: user_2)
      create(:order_item, order: order_pending, item: item_4, price: 2, quantity: 1)

      expect(merchant_1.pending_orders).to eq([order_pending, order_pending_2])
      expect(merchant_1.pending_orders).to_not eq([order_fulfilled, order_pending_3])
    end
    it '#top_5' do

      merchant = create(:user, role: 1)
      item_1 = create(:item, user:merchant)
      item_2 = create(:item, user:merchant)
      item_3 = create(:item, user:merchant)
      item_4 = create(:item, user:merchant)
      item_5 = create(:item, user:merchant)
      item_6 = create(:item, user:merchant)
      order = create(:completed_order, user_id:merchant.id)
      create(:fulfilled_order_item,  order:order, item: item_1, price: 1, quantity: 22)
      create(:fulfilled_order_item,  order:order, item: item_2, price: 1, quantity: 23)
      create(:fulfilled_order_item,  order:order, item: item_3, price: 1, quantity: 24)
      create(:fulfilled_order_item,  order:order, item: item_4, price: 1, quantity: 25)
      create(:fulfilled_order_item,  order:order, item: item_5, price: 1, quantity: 26)
      create(:fulfilled_order_item,  order:order, item: item_6, price: 1, quantity: 1)
      merchant.top_5

      expect(merchant.top_5).to eq([item_5, item_4, item_3, item_2, item_1])
      expect(merchant.top_5).to_not eq([item_6])
    end
  end
end
