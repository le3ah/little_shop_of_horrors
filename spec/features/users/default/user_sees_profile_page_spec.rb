require 'rails_helper'

describe 'as a registered user' do
  it 'displays profile page if I am logged in' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path

    expect(current_path).to eq profile_path
    expect(page).to have_content("Welcome, #{user.name}!")
    expect(page).to have_content("Email: #{user.email}")
    expect(page).to have_content("Address: #{user.address}")
    expect(page).to have_content("City: #{user.city}")
    expect(page).to have_content("State: #{user.state}")
    expect(page).to have_content("Zip: #{user.zip}")
    expect(page).to have_link('Edit Profile', href: profile_edit_path)
  end
end
