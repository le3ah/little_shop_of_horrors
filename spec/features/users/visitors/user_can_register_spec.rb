require 'rails_helper'

describe 'as a visitor' do
  it "can register a new user" do
    username = "Anthony"

    visit root_path

    click_on 'Sign Up'
    expect(current_path).to eq('/register')

    fill_in :user_username, with: username
    fill_in :user_password, with: "test"

    click_on 'Create User'

    expect(page).to have_content("Welcome, #{username}")

  end
end
