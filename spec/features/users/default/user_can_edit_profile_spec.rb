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

  it 'should show form with all user information' do
    visit profile_edit_path

    expect(find_field(:user_name).value).to eq @user.name
    expect(find_field(:user_email).value).to eq @user.email
    expect(find_field(:user_address).value).to eq @user.address
    expect(find_field(:user_city).value).to eq @user.city
    expect(find_field(:user_state).value).to eq @user.state
    expect(find_field(:user_zip).value.to_i).to eq @user.zip
  end
end
