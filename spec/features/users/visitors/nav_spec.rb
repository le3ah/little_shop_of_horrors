require 'rails_helper'

describe 'navigation' do
  before :each do
    visit root_path
  end
  it "links to appropriate page" do
    click_link "Home"
    expect(current_path).to eq(root_path)
    click_link "Browse Items"
    expect(current_path).to eq(items_path)
    click_link "Browse Merchants"
    expect(current_path).to eq(merchants_path)
    click_link "Shopping Cart"
    expect(current_path).to eq(cart_path)
    click_link "Login"
    expect(current_path).to eq(login_path)
    click_link "Register"
    expect(current_path).to eq('/register')
  end
end
