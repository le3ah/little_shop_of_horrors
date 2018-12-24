require  'rails_helper'

describe 'As an admin merchant' do
  context 'when I visit the merchant index page' do
    it "should disable an enabled merchant" do
      @admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1, enabled: false)

      visit admin_merchants_path
      click_button "disable"

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("#{@merchant_1.name} is now disabled.")
      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button("enable")
      end 
    end
  end
end
