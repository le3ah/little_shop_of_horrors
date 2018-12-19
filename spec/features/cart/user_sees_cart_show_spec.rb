require 'rails_helper'

describe 'As a visitor or default user' do
  it 'shows the cart page' do

    visit cart_path

    expect(page).to have_content("Shopping Cart")
    expect(page).to have_content("Your cart is empty!")
    expect(page).to_not have_link("Empty Cart")

    user = create(:user)

    visit cart_path(user)

    expect(page).to have_content("Shopping Cart")
    expect(page).to have_content("Your cart is empty!")
    expect(page).to_not have_link("Empty Cart")
  end
end