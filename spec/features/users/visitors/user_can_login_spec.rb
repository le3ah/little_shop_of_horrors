require "rails_helper"

describe 'as a registered user' do
  it "should login" do
    user = User.create(name: "Anthony", password: "test", email: "Tony@gmail.com", address: "1609 Rose St. NW", city: "Cullman", state: "AL", zip: 35055)

    visit root_path
    click_on "login"

    expect(current_path).to eq(login_path)

    fill_in "email", with: user.email
    fill_in "password", with: user.password


    click_on "submit"

    expect(current_path).to eq(profile_path)

    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_content("log out")
    expect(page).to have_content("Hooray!")
  end
  it "should show error flash if incorrect login" do
    user = User.create(name: "Anthony", password: "test", email: "Tony@gmail.com", address: "1609 Rose St. NW", city: "Cullman", state: "AL", zip: 35055)
    visit root_path
    click_on "login"
    expect(current_path).to eq(login_path)
    fill_in "email", with: user.email
    click_on "submit"
    expect(page).to_not have_content("Welcome, #{user.name}")
    expect(page).to have_content("Registered User Login")
    expect(page).to have_content("Oh no!")
  end
end
