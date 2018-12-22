require "rails_helper"

describe "User Edit Profile" do
  it 'should link from profile page' do
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit profile_path
    
    click_link "Edit Profile"

    expect(current_path).to eq(profile_edit)
  end
end
