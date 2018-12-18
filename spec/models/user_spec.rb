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
        it { should validate_presence_of(:enabled) }
        it { should validate_presence_of(:address) }
        it { should validate_presence_of(:city) }
        it { should validate_presence_of(:zip) }
        it { should validate_presence_of(:state) }
    end

    describe 'should require uniqueness of' do
        it { should validate_uniqueness_of(:email) }
    end

  end

end
