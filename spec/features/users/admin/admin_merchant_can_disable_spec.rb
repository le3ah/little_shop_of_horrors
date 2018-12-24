require  'rails_helper'

describe 'As an admin merchant' do
  context 'when I visit the merchant index page' do
    it "should disable an enabled merchant" do
      @admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1, enabled: false)

      visit admin_merchants_path
      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_button("enable")
      end
      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button("disable")
        click_button "disable"
      end

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("#{@merchant_1.name}'s account is now disabled.")
      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button("enable")
      end
    end
    it "prevents disabled user from logging in" do
      @merchant_1 = create(:user, role: 1, enabled: false)
      visit login_path

      fill_in "email", with: @merchant_1.email
      fill_in "password", with: @merchant_1.password

      click_on "submit"

      expect(current_path).to eq(login_path)
    end
  end
end
