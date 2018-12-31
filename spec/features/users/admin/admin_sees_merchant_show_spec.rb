require 'rails_helper'

describe "As an admin" do
  describe "when I visit merchant dashboard" do
    it "displays everything a merchant would see" do
      admin = create(:user, email: "admin@admin.com", role:2)
      merchant = create(:user, email: "test@test.com", role:1, )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_merchant_path(merchant)

      expect(page).to have_content("Email")
      expect(page).to have_content("test@test.com")
      expect(page).to have_content("Top 5 Items")
      expect(page).to have_content("Pending Orders")
      expect(page).to have_link("View My Items")
    end
  end
end