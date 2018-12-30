require 'rails_helper'

describe "As a merchant" do
    context "on /dashboard/items" do
        it "can delete an item & see a flash message" do
            merchant = create(:user, role: 1)
            item = create(:item, user:merchant, thumbnail:"oldguy.jpeg")
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
            visit dashboard_items_path
            save_and_open_page
            within "#item-#{item.id}" do 
                expect(page).to have_button("delete")
                click_button "delete"
            end 
            save_and_open_page
            expect(current_path).to eq(dashboard_items_path)
            expect(page).to have_content("item successfully deleted!") 


        end
    end
end
