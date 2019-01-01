require "rails_helper"

describe "Merchant Enable/Disable Item" do
  context 'when merchant visits dashboard_items page' do
    before :each do
      @m = create(:user, role: 1)
      @i_1 = create(:item, user: @m, enabled: false)
      @i_2 = create(:item, user: @m)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m)
      visit dashboard_items_path
    end

    it 'shows button to enable or disable and clicking redirects back to dashboard_items' do
      expect(page).to have_button("Enable", count: 1)
      expect(page).to have_button("Disable", count: 1)

      click_button "Enable"
      expect(current_path).to eq(dashboard_items_path)
      expect(page).to have_button("Disable", count: 2)

      first(:button, "Disable").click
      expect(current_path).to eq(dashboard_items_path)
    end

    it 'clicking button to enable or disable updates item and show appropriate flash message' do
      click_button "Enable"
      expect(page).to have_content("Item is available for sale!")

      @i_2.reload
      expect(@i_2.enabled).to be_truthy

      first(:button, "Disable").click
      expect(page).to have_content("Item is no longer available for sale!")
      @i_1.reload
      expect(@i_1.enabled).to be_falsey
    end
  end
end
