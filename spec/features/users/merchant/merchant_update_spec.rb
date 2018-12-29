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
      
      expect(current_path).to eq(edit_item_path) 
    end
  end
end
