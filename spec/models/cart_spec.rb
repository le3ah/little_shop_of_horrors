require 'rails_helper'

describe Cart do
  describe 'items' do
    it 'returns an array of CartItems' do
      user = create(:user)
      item = create(:item, user_id: user.id)
      data = Hash.new(0)
      data[item.id] = 2
      cart = Cart.new(data)

      expect(cart.items.first).to be_a_kind_of(CartItem)
    end
  end
end