require 'rails_helper'

describe 'as a visitor' do
  it "can register a new user" do
    name = "Anthony"
    email = "Tony@gmail.com"
    address = "1609 Rose St. NW"
    city = "Cullman"
    state = "AL"
    zip = 35055

    visit root_path

    click_on 'Sign Up'
    expect(current_path).to eq('/register')

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: "test"
    fill_in :user_confirm_password, with: "test"
    fill_in :user_address, with: address
    fill_in :user_city, with: city
    fill_in :user_state, with: state
    fill_in :user_zip, with: zip

    click_on 'Create User'
    expect(current_path).to eq(profile_path)
    expect(page).to have_content("Welcome, #{name}")

  end
  it "will render form again if missing registration info" do
    name = "Tony II"

    visit root_path

    click_on 'Sign Up'
    expect(current_path).to eq('/register')
    fill_in :user_name, with: name
    click_on 'Create User'
    expect(page).to have_content("User Registration Form")
  end
  it "cannot repeat email addresses" do
    user_1 = User.create(name: "Anthony", password: "test", email: "Tony@gmail.com", address: "1609 Rose St. NW", city: "Cullman", state: "AL", zip: 35055)

    name = "Tony II"
    email = "Tony@gmail.com"
    address = "429 County Rd. 420"
    city = "Cullman"
    state = "AL"
    zip = 35057

    visit root_path

    click_on 'Sign Up'
    expect(current_path).to eq('/register')

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: "test"
    fill_in :user_confirm_password, with: "test"
    fill_in :user_address, with: address
    fill_in :user_city, with: city
    fill_in :user_state, with: state
    fill_in :user_zip, with: zip

    click_on 'Create User'
    expect(page).to have_content("User Registration Form")
    expect(page).to have_content("Cannot repeat email address!")
  end
end
