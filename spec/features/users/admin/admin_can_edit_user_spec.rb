require "rails_helper"

describe "Admin Edit User" do
  context "when admin visits edit_admin_user_path through admin_user_path" do
    before :each do
      @u = create(:user)
      @a = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)
    end

    it 'does same behavior to edit as if default user except redirect' do
      visit admin_user_path(@u)

      click_link "Edit Profile"

      expect(current_path).to eq(edit_admin_user_path(@u))

      expect(find_field(:user_name).value).to eq @u.name
      expect(find_field(:user_email).value).to eq @u.email
      expect(find_field(:user_address).value).to eq @u.address
      expect(find_field(:user_city).value).to eq @u.city
      expect(find_field(:user_state).value).to eq @u.state
      expect(find_field(:user_zip).value.to_i).to eq @u.zip

      expect(find_field(:user_password).value).to be_nil

      fill_in :user_name, with: "John"
      fill_in :user_email, with: "john@gmail.com"

      click_on "Update User"
      expect(@u.name).to eq("John")
      expect(@u.email).to eq("john@gmail.com")

      expect(current_path).to eq(admin_user_path(@u))
      expect(page).to have_content("You've successfully edited the user's profile!")
    end
  end
end
