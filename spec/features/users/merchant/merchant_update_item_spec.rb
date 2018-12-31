require 'rails_helper'

describe "As a Merchant" do
  context "On /dashboard/items" do
    before :each do
      merchant = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)
      @item = create(:item, user: merchant, thumbnail: "plant_10")
      visit dashboard_items_path
 
    end

    it "sees a link to edit and can edit images" do
      within "#item-#{@item.id}" do
        click_link "edit"
      end 
      
      expect(current_path).to eq(edit_item_path(@item))

      fill_in "Thumbnail", with: "plant_11"
      click_button "Update Item"

      @item.reload
      expect(current_path).to eq(dashboard_items_path)
      expect(page.find('#plant_11')['alt']).to match("Plant 11")
    end

    it "can update an image to be blank and image will show default image" do
      within "#item-#{@item.id}" do
        click_link "edit"
      end 

      fill_in "Thumbnail", with: ""
      click_button "Update Item"

      @item.reload
      
      expect(page.find('#no_img')['alt']).to match("No img")
    end

    it 'shows flash messages if required fields are blank' do
      within "#item-#{@item.id}" do
        click_link "edit"
      end 

      fill_in "Name", with: ""
      fill_in "Description", with: ""
      click_button "Update Item"

      @item.reload

      expect(page).to have_content("name cannot be blank")
      expect(page).to have_content("description cannot be blank")
    end
  end
end
