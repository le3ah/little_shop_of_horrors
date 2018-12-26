require "rails_helper"

describe "User Edit Profile" do
  before :each do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it 'should link from profile page' do
    visit profile_path

    click_link "Edit Profile"

    expect(current_path).to eq(profile_edit_path)
  end

  it 'should show form with all user information except password' do
    visit profile_edit_path

    expect(find_field(:user_name).value).to eq @user.name
    expect(find_field(:user_email).value).to eq @user.email
    expect(find_field(:user_address).value).to eq @user.address
    expect(find_field(:user_city).value).to eq @user.city
    expect(find_field(:user_state).value).to eq @user.state
    expect(find_field(:user_zip).value.to_i).to eq @user.zip

    expect(find_field(:user_password).value).to be_nil
  end

  it 'should be able to update some user information' do
    visit profile_edit_path

    fill_in :user_name, with: "John"
    fill_in :user_email, with: "john@gmail.com"

    click_on "Update User"

    expect(current_path).to eq(profile_path)
    expect(page).to have_content("Welcome, John!")
    expect(page).to have_content("Email: john@gmail.com")
    expect(@user.name).to eq("John")
    expect(@user.email).to eq("john@gmail.com")

    expect(page).to have_content(@user.address)
    expect(page).to have_content(@user.city)
    expect(page).to have_content(@user.state)
    expect(page).to have_content(@user.zip)
    expect(page).to have_content("You successfully edited your profile!")
  end

  it 'should be able to update all user information' do
    visit profile_edit_path

    name = "Tony II"
    email = "Tony@gmail.com"
    address = "429 County Rd. 420"
    city = "Cullman"
    state = "AL"
    zip = 35057

    fill_in :user_name, with: name
    fill_in :user_email, with: email
    fill_in :user_password, with: "test"
    fill_in :user_confirm_password, with: "test"
    fill_in :user_address, with: address
    fill_in :user_city, with: city
    fill_in :user_state, with: state
    fill_in :user_zip, with: zip

    click_on "Update User"

    expect(current_path).to eq(profile_path)
    expect(page).to have_content("Welcome, #{name}!")
    expect(page).to have_content("Email: #{email}")
    expect(page).to have_content("Address: #{address}")
    expect(page).to have_content("City: #{city}")
    expect(page).to have_content("State: #{state}")
    expect(page).to have_content("Zip: #{zip}")

    expect(@user.name).to eq(name)
    expect(@user.email).to eq(email)
    expect(@user.password).to eq("test")
    expect(@user.address).to eq(address)
    expect(@user.city).to eq(city)
    expect(@user.state).to eq(state)
    expect(@user.zip).to eq(zip)

    expect(page).to have_content("You successfully edited your profile!")
  end

  it 'should not allow changing email to one that is in use' do
    user_2 = create(:user, email: "j@gmail.com")

    visit profile_edit_path

    fill_in :user_email, with: "j@gmail.com"
    click_on "Update User"

    expect(current_path).to eq(profile_edit_path)
    expect(page).to have_content("That email is in use, please pick another")
  end
end
