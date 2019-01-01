require 'rails_helper'

describe 'As an admin when I visit a merchants items' do
  describe 'I have access to all functionality the merchant does' do
    context 'creat/delete functionality' do
      it "can create and delete an item" do
        admin = create(:user, role: 2)
        merchant = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_merchant_items_path(merchant)

        click_on 'add new item'

        expect(current_path).to eq(new_admin_merchant_item_path(merchant))

        fill_in "Name",	with: "Testing"
        fill_in "Description",	with: "123"
        fill_in "Price",	with: "11"
        fill_in "Inventory",	with: "456"
        click_on "Create Item"

        expect(current_path).to eq(admin_merchant_items_path(merchant))

        expect(page).to have_content("Testing")
        expect(page).to have_content("11")
        expect(page).to have_content("456")

        expect(page).to have_content("Item added!")

        item = Item.find_by(name: "Testing")

        within "#item-#{item.id}" do
          expect(page).to have_button("delete")
          click_button "delete"
        end

        expect(page).to have_content("Item successfully deleted!")

        item = Item.find_by(name: "Testing")

        expect(item).to_not be_truthy
      end

      it 'shows flash message if required fields are blank' do
        admin = create(:user, role: 2)
        merchant = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

        visit admin_merchant_items_path(merchant)

        click_on 'add new item'

        expect(current_path).to eq(new_admin_merchant_item_path(merchant))

        fill_in "Price",	with: "11"
        fill_in "Inventory",	with: "456"
        click_on "Create Item"

        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("Description can't be blank")
      end
    end

    context 'update functionality' do
      it "sees a link to edit and can edit images" do
        admin = create(:user, role: 2)
        merchant = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
        item = create(:item, user: merchant, thumbnail: "plant_10")
        visit admin_merchant_items_path(merchant)

        within "#item-#{item.id}" do
          click_link "edit"
        end

        expect(current_path).to eq(edit_admin_merchant_item_path(merchant, item))

        fill_in "Name", with: "Cool name"
        fill_in "Description", with: "Cool plant"
        fill_in "Price", with: "11"
        fill_in "Thumbnail", with: "plant_29"

        click_button "Update Item"

        item.reload

        expect(current_path).to eq(admin_merchant_items_path(merchant))
        expect(page).to have_content("Cool name")
        expect(page).to have_content("11")
        expect(page.find('#plant_29')['alt']).to match("Plant 29")
      end
    end

    context 'enable/disable functionality' do
      before :each do
        @a = create(:user, role: 2)
        @m = create(:user, role: 1)
        @i_1 = create(:item, user: @m, enabled: false)
        @i_2 = create(:item, user: @m)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)
        visit admin_merchant_items_path(@m)
      end

      it 'shows button to enable or disable and clicking redirects back to dashboard_items with flash message' do
        expect(page).to have_button("Enable", count: 1)
        expect(page).to have_button("Disable", count: 1)

        click_button "Enable"
        expect(current_path).to eq(admin_merchant_items_path(@m))
        expect(page).to have_content("Item is available for sale!")
        expect(page).to have_button("Disable", count: 2)

        first(:button, "Disable").click
        expect(page).to have_content("Item is no longer available for sale!")
        expect(page).to have_button("Disable", count: 1)
        expect(current_path).to eq(admin_merchant_items_path(@m))
      end
    end
  end
end
