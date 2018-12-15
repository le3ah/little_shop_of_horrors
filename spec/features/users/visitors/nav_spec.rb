require 'rails_helper'

describe 'navigation' do
  before :each do
    visit root_path
  end
  it "should link to home page" do
    click_link "home"
    expect(current_path).to eq(root_path)
  end
  it "should link to items index page" do
    click_link "browse items"
    expect(current_path).to eq(items_path)
  end
  it "should link to merchant index page" do
    click_link "browse merchants"
    expect(current_path).to eq(merchants_path)
  end
  it "should link to shopping cart page" do
    click_link "shopping cart"
    expect(current_path).to eq('/cart')
  end
  it "should link to login page" do
    click_link "login"
    expect(current_path).to eq('/login')
  end
  it "should link to registration page" do
    click_link "user registration"
    expect(current_path).to eq('/register')
  end
end
