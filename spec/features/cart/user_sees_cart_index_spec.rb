require 'rails_helper'

describe 'As a visitor or default user' do
  it 'shows the cart page' do

    visit cart_path

    expect(page).to have_content("Your Cart")
    expect(page).to have_content("Your cart is empty!")
    expect(page).to_not have_link("Empty Cart")

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit cart_path

    expect(page).to have_content("Your Cart")
    expect(page).to have_content("Your cart is empty!")
    expect(page).to_not have_link("Empty Cart")
  end

  it 'should show message to register or login to checkout - if not' do
    user = create(:user, role: 1)
    item = create(:item, user_id: user.id)
    item_2 = create(:item, user_id: user.id)

    visit item_path(item)
    click_button "Add to Cart"
    visit item_path(item_2)
    click_button "Add to Cart"

    click_link "Shopping Cart"

    expect(page).to have_content("You must register or be logged in to checkout")

    click_link "Login"
    expect(current_path).to eq(login_path)

    visit cart_path
    click_link "Register"
    expect(current_path).to eq(register_path)
  end

  it 'shoud not show message if logged in' do
    m = create(:user, role: 1)
    u = create(:user)
    item = create(:item, user_id: m.id)
    item_2 = create(:item, user_id: m.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(u)

    visit item_path(item)
    click_button "Add to Cart"
    visit item_path(item_2)
    click_button "Add to Cart"

    click_link "Shopping Cart"

    expect(page).to_not have_content("You must register or be logged in to checkout")
  end

  it 'shows item information when a user or visitor has item in cart' do
    user = create(:user, role: 1)
    item = create(:item, user_id: user.id, price: 10, thumbnail: "plant_1")
    item_2 = create(:item, user_id: user.id, price: 10, thumbnail: "plant_2")

    visit item_path(item)
    click_button "Add to Cart"
    visit item_path(item)
    click_button "Add to Cart"
    visit item_path(item_2)
    click_button "Add to Cart"

    click_link "Shopping Cart"
    
    expect(page).to have_content(item.name)
    expect(page).to have_content(item.price)
    
    within ".cart_thumbnail_0" do
      expect(page.find('#cart_img_0')['alt']).to match("Plant 1")
    end
    expect(page).to have_content(item.user.name)
    expect(page).to have_content(2)
    expect(page).to have_content(20)
    expect(page).to have_content(30)
  end
end
