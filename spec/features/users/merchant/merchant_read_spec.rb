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

            click_on "Dashboard"
            expect(current_path).to eq(dashboard_path) 
            
        end 

        it 'cannot be seen by a visitor' do 
            visit root_path

            within ".nav" do 
                expect(page).to_not have_content("Profile") 
                expect(page).to_not have_content("Orders") 
                expect(page).to_not have_content("logout") 
                expect(page).to_not have_content("Dashboard") 
            end

            visit dashboard_path

            expect(page).to have_content("The page you were looking for doesn't exist.")


        end

        it 'dashboard cannot be seen by a user' do
            user = create(:user, role:0)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

            
            visit root_path

            within ".nav" do 
                expect(page).to_not have_content("Dashboard") 
            end

            visit dashboard_path

            expect(page).to have_content("The page you were looking for doesn't exist.")

        end

    end
    

end
