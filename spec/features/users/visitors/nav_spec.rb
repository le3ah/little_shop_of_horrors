require 'rails_helper'

describe 'navigation' do
  before :each do
    visit root_path
  end
  xit "should link to home page" do
    click_link "home"
    expect(current_path).to eq(root_path)
    click_link "browse items"
    expect(current_path).to eq(items_path)
    click_link "browse merchants"
    expect(current_path).to eq(merchants_path)
    click_link "shopping cart"
    expect(current_path).to eq('/cart')
    click_link "login"
    expect(current_path).to eq('/login')
    click_link "user registration"
    expect(current_path).to eq('/register')
  end
end
