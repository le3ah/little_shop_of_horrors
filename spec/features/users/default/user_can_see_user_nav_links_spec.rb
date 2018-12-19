require "rails_helper"

RSpec.describe "As a user" do
  context "When I Navigate the Site" do
    it "can see specific user links in the nav" do
        user = create(:user, name: "oh holy night", role:0)
        
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit merchants_path 
        within(".nav") do
            expect(page).to have_content("Profile")
            expect(page).to have_content("Orders")
            expect(page).to have_content("Logout")
        end

        click_on('Profile')
        expect(current_path).to eq(profile_path)
        
        click_on('Orders')
        expect(current_path).to eq(orders_path) 
        
        click_on('Logout')
        expect(current_path).to eq(logout_path)
    end
  end
end
