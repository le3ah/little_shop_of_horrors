require  'rails_helper'

describe 'As an admin merchant' do
  context 'when I visit the merchant index page' do
    it "should be able to disable and enable a merchant" do
      @admin = create(:user, role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 1, enabled: false)

      visit admin_merchants_path

      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_button("enable")
        click_button "enable"
        @merchant_2.reload
        expect(@merchant_2.enabled?).to be_truthy
      end

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("#{@merchant_2.name}'s account is now enabled.")

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button("disable")
        click_button "disable"
        @merchant_1.reload
        expect(@merchant_1.enabled?).to be_falsy
      end

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("#{@merchant_1.name}'s account is now disabled.")

      within "#merchant-#{@merchant_1.id}" do
        expect(page).to have_button("enable")
      end
      within "#merchant-#{@merchant_2.id}" do
        expect(page).to have_button("disable")
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

  context "when I visit a merchant's dashboard" do

    it 'should be able to downgrade the merchant to a regular user' do 
      admin = create(:user, role: 2)
      brad = create(:user, role: 1, name: "brad")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit merchants_path
      click_on "brad"

      expect(current_path).to eq(admin_merchant_path(brad)) 
      expect(page).to have_button("Downgrade to User") 

      click_button "Downgrade to User"

      brad.reload

      expect(page).to have_button("Upgrade to Merchant")
    end
    
  end
  
end
