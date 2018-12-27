require 'rails_helper'

describe "As a Merchant" do
  context "on dashboard/items i see" do
    it "a link to create an item" do
      visit dashboard_items_path

      click_on 'add new item'

      expect(current_path).to eq(dashboard_items_new_path) 
      
      fill_in "Name",	with: "Testing"
      fill_in "Description",	with: "123" 
      fill_in "thumbnail",	with: "FIXME: SHOULD BE IMAGE" 
      fill_in "Price",	with: "11" 
      fill_in "Inventory",	with: "123" 
      click_on "Create Item"

      expect(current_path).to eq(dashboard_items_path)
    end
  end
end
