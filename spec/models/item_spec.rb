require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:thumbnail)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:inventory)}
    it {should validate_inclusion_of(:enabled).in_array([true,false])}
  end

  describe "relationships" do
    describe 'to orders' do
      it {should have_many(:order_items)}
      it {should have_many(:orders).through(:order_items)}
      it {should belong_to(:user)}
    end
  end
  describe  "Model Tests" do
    it ".fulfillment_time" do

      expect(item.fulfillment_time).to eq()

    end
  end
end
