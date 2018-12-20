require 'rails_helper'

describe 'As a visitor or default user' do
  it 'allows me to add an items to the cart and they display in cart show page' do
    user = create(:user, role: 1)
    item = create(:item, user_id: user.id)

    visit item_path(item)

    expect(page).to have_content(item.name)
    
    click_button "Add to Cart"

    expect(current_path).to eq items_path

    visit item_path(item)
    click_button "Add to Cart"
    click_link "shopping cart"

    expect(page).to have_content("Shopping Cart")

    within ".cart_item_0" do
      expect(page).to have_content(item.name)
    end

    within ".quantity_0" do
      expect(page).to have_content(2)
    end

  end
end 