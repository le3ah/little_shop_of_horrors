require 'rails_helper'

describe 'as a registered user' do
  it 'displays logout if user is logged in and redirects to home page on logout' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path

    expect(current_path).to eq profile_path

    within ".nav" do
      expect(page).to have_content("logout")
    end

    click_link "logout"

    expect(current_path).to eq root_path
  end
end
