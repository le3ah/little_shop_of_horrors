require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:quantity)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:fulfilled)}
  end

  describe 'relationships' do
    xit {should belong_to(:item)}
    xit {should belong_to(:order)}
  end
end
