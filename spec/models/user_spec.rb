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
  end
  describe  "Model Tests" do
    it ".fulfillment_time" do
      merchant_1 = create(:user, role: 1)
      item_1 = merchant_1.items.create(
        name: 'Flower Pot',
        description: 'Messy Pot',
        thumbnail: 'thumbnail',
        price: 4,
        inventory: 5,
        enabled: true
      )

      expect(item_1.fulfillment_time).to eq()

    end
  end
end
