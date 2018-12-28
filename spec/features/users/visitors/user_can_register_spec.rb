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
    click_on 'Register'

    expect(current_path).to eq('/register')

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: "test"
    fill_in :user_password_confirmation, with: "test"
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

    click_on 'Register'
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

    click_on 'Register'
    expect(current_path).to eq('/register')

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: "test"
    fill_in :user_password_confirmation, with: "test"
    fill_in :user_address, with: address
    fill_in :user_city, with: city
    fill_in :user_state, with: state
    fill_in :user_zip, with: zip

    click_on 'Create User'
    expect(page).to have_content("User Registration Form")
    expect(page).to have_content("Email has already been taken")
    expect(find_field(:user_name).value).to eq name
    expect(find_field(:user_email).value).to_not eq email
    expect(find_field(:user_address).value).to eq address
    expect(find_field(:user_city).value).to eq city
    expect(find_field(:user_state).value).to eq state
    expect(find_field(:user_zip).value).to eq "35057"
  end


  it 'should display flash message if passwords do not match' do
    name = "Tony II"
    email = "Tony@gmail.com"
    address = "429 County Rd. 420"
    city = "Cullman"
    state = "AL"
    zip = 35057

    visit root_path

    click_on 'Register'
    expect(current_path).to eq('/register')

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: "test"
    fill_in :user_password_confirmation, with: "wrong"
    fill_in :user_address, with: address
    fill_in :user_city, with: city
    fill_in :user_state, with: state
    fill_in :user_zip, with: zip

    click_on 'Create User'

    expect(page).to have_content("User Registration Form")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
