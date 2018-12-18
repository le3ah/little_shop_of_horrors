require 'rails_helper'

describe 'as a registered user' do
  xit "can log out of session" do
    user = User.create(name: "Anthony", password: "test", email: "Tony@gmail.com", address: "1609 Rose St. NW", city: "Cullman", state: "AL", zip: 35055)
    visit root_path
    click_on "login"
    expect(current_path).to eq(login_path)
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "submit"
    expect(current_path).to eq(profile_path)

    within 'nav'


  end
end
