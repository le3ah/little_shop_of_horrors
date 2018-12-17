require "rails_helper"

describe 'as a registered user' do
  it "should login" do
    user = User.create(email: "tony@gmail.com", password: "test")

    visit root_path
    click_on "log in"

    expect(current_path).to eq(login_path)

    fill_in "email", with: user.email
    fill_in "password", with: user.password

    click_on "log in"

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_content("log out")
  end
end
