require 'rails_helper'

describe CartItem do
  it 'returns the name of the item' do
    user = create(:user, role: 1)
    item = create(:item, user_id: user.id)
    cart_item = CartItem.new(item)
    
    expect(cart_item.name).to eq "Item 1"
  end

  it 'returns the quantity for an item list' do
    user = create(:user, role: 1)
    item = create(:item, user_id: user.id)
    cart_item = CartItem.new(item, 2)

    expect(cart_item.quantity).to eq 2
  end
end