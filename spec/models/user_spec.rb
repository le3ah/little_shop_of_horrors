require "rails_helper"

RSpec.describe User, type: :model do
  context "Validations" do
    context "relationships" do
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
    end
  end

end
