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
            expect(page).to have_content("logout")
        end

        click_on('Profile')
        expect(current_path).to eq(profile_path)
        
        click_on('Orders')
        expect(current_path).to eq(profile_orders_path) 

        click_on('logout')
        expect(current_path).to eq(root_path)
    end

    it "can not see login or sign up" do 
        user = create(:user, name: "oh holy night", role:0)
        
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit merchants_path

        expect(page).to_not have_content("login")  
        expect(page).to_not have_content("Sign Up")  
    end 

    it 'can see "sup, #{users name}"' do 
        user = create(:user, name: "oh holy night", role:0)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        visit merchants_path

        expect(page).to have_content("Logged in as #{user.name}")
    end 

    it "sad path - you can't see shit" do
        
        visit merchants_path 
        
        within(".nav") do
            expect(page).to_not have_content("Profile")
            expect(page).to_not have_content("Orders")
            expect(page).to_not have_content("logout")
        end

    end


  end
end
