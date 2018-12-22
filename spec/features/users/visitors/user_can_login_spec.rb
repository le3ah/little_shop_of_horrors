require "rails_helper"

describe 'as a registered user' do
  it "should login users" do
    user = create(:user)
    
    visit root_path
    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "email", with: user.email
    fill_in "password", with: user.password


    click_on "submit"

    expect(current_path).to eq(profile_path)

    expect(page).to have_content("Welcome, #{user.name}")
    expect(page).to have_content("Logout")
    expect(page).to have_content("Hooray!")
  end

  it "should login merchants" do
    user = create(:user, role: 1)
    
    visit root_path
    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "email", with: user.email
    fill_in "password", with: user.password


    click_on "submit"

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Welcome, merchant #{user.name}!")
    expect(page).to have_content("Hooray!")
    expect(page).to have_content("Logout")
    
  end

  it "should login admin" do
    user = create(:user, role: 2)
    
    visit root_path
    click_on "Login"

    expect(current_path).to eq(login_path)

    fill_in "email", with: user.email
    fill_in "password", with: user.password


    click_on "submit"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Little Shop of Horrors!")
    expect(page).to have_content("Hooray!")
    expect(page).to have_content("Logout")
  end
end
