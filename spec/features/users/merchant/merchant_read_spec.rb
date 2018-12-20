require 'rails_helper'

describe "As a Merchant" do
    context "navigation" do
        it 'can view the merchant nav bar' do 
            merchant = create(:user, role:1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

            visit root_path

            within ".nav" do 
                expect(page).to have_content("home") 
                expect(page).to have_content("browse items") 
                expect(page).to have_content("browse merchants") 
                expect(page).to have_content("Profile") 
                expect(page).to have_content("Orders") 
                expect(page).to have_content("logout") 
                expect(page).to have_content("Dashboard") 
            end

            
        end 
    end
    

end
