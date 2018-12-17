require "rails_helper"

describe 'Login Page' do
  xit 'should show login form' do
    visit login_path

    expect(page).to have_content("Email")
    expect(page).to have_content("Password")
  end

  it 'should create a user' do

  end
end
