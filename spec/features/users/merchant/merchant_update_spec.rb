require 'rails_helper'

describe "As a Merchant" do
  context "On /dashboard/items" do
    it "sees a link to edit and can edit images" do
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      item = create(:item, user: merchant, thumbnail: "plant_10")
      visit dashboard_items_path

      within "#item-#{item.id}" do
        click_link "edit"
      end
      expect(current_path).to eq(edit_item_path(item))

      fill_in "Thumbnail", with: "plant_11"
      click_button "Update Item"

      item.reload
      expect(current_path).to eq(dashboard_items_path)
      expect(page.find('#plant_11')['alt']).to match("Plant 11")
    end
  end

  context "merchant updates item flash messages for each issue" do
    context 'merchant sees a flash message for each error' do 
      it 'sees an error for missing name, description' do 
        merchant = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path
        click_on 'add new item'

        fill_in "Price",	with: "11"
        fill_in "Inventory",	with: "456"
        click_on "Create Item"

        expect(page).to have_content("Name cannot be blank")
        expect(page).to have_content("Description cannot be blank")
      end 

      it 'sees an error for missing price, inventory' do 
        merchant = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_items_path
        click_on 'add new item'

        fill_in "Price",	with: "11"
        fill_in "Inventory",	with: "456"
        click_on "Create Item"

        expect(page).to have_content("Price cannot be blank")
        expect(page).to have_content("Inventory cannot be blank")
      end 
    end 
    
  end
  
end
