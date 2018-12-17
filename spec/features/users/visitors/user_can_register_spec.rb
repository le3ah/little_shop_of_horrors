require 'rails_helper'

describe 'as a visitor' do
  it "can register a new user" do
    username = "Anthony"

    visit root_path

    click_on 'sign up'
    expect(current_path).to eq(new_user_path)

    fill_in :user_username, with: username
    fill_in :user_password, with: "test"

    click_on 'Create User'

    expect(page).to have_content("Welcome, #{username}")

  end
end
