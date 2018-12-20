require 'rails_helper'

describe 'As a visitor or default user' do
  it 'allows me to add an items to the cart and they display in cart show page' do
    user = create(:user, role: 1)
    item = create(:item, user_id: user.id)
    item_2 = create(:item, user_id: user.id)

    visit item_path(item)

    expect(page).to have_content(item.name)
    
    click_button "Add to Cart"

    expect(current_path).to eq items_path

    within ".nav" do
      expect(page).to have_content("shopping cart (1)")
    end

    expect(page).to have_content("Item has been added to your cart")

    visit item_path(item)
    click_button "Add to Cart"
    
    within ".nav" do
      expect(page).to have_content("shopping cart (1)")
    end
    
    visit item_path(item_2)
    click_button "Add to Cart"
    
    within ".nav" do
      expect(page).to have_content("shopping cart (2)")
    end

    click_link "shopping cart"
    
    expect(page).to have_content("Your Cart")

    within ".cart_item_0" do
      expect(page).to have_content(item.name)
    end

    within ".quantity_0" do
      expect(page).to have_content(2)
    end
  end
end 