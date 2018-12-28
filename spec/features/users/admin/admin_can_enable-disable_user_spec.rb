require "rails_helper"

describe "Admin Enable/Disable User" do
  context "when admin visits users index" do
    before :each do
      @u = create(:user)
      @d_u = create(:user, enabled: false)
      @a = create(:user, role: 2)
    end

    it 'redirects to users index after enabling or disabling and reflects changes' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)
      visit admin_users_path

      click_button "Enable"
      expect(current_path).to eq(admin_users_path)
      expect(page).to have_button("Disable", count: 2)


      within "#user-#{@u.id}" do
        click_button "Disable"
      end

      expect(current_path).to eq(admin_users_path)
      expect(page).to have_button("Disable", count: 1)
      expect(page).to have_button("Enable", count: 1)
    end

    it 'shows appropriate flash message after enabling or disabling' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)
      visit admin_users_path
      click_button "Enable"
      expect(page).to have_content("#{@d_u.name}'s account is now enabled.")

      within "#user-#{@u.id}" do
        click_button "Disable"
      end
      expect(page).to have_content("#{@u.name}'s account is now disabled.")
    end

    it 'allows or prevents user from logging in after enabling/disabling' do
      visit login_path
      fill_in "email", with: @a.email
      fill_in "password", with: @a.password
      click_on "submit"

      visit admin_users_path
      click_button "Enable"
      click_link "Logout"

      visit login_path
      fill_in "email", with: @d_u.email
      fill_in "password", with: @d_u.password
      click_on "submit"
      expect(current_path).to eq(profile_path)
      expect(page).to have_content("Welcome, #{@d_u.name}")
      click_link "Logout"

      visit login_path
      fill_in "email", with: @a.email
      fill_in "password", with: @a.password
      click_on "submit"
      
      visit admin_users_path
      within "#user-#{@u.id}" do
        click_button "Disable"
      end
      click_link "Logout"

      visit login_path
      fill_in "email", with: @u.email
      fill_in "password", with: @u.password
      click_on "submit"
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Incorrect username or password. 🤯 🥀")
    end
  end
end
