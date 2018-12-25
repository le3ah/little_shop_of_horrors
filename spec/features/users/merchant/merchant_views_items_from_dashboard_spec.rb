require 'rails_helper'

describe "As a merchant" do
  context 'When I visit my dashboard' do
      it "sees a link to view my own items" do
        merchant = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

        visit dashboard_path
        expect(page).to have_link("View My Items")
        click_link "View My Items"

        expect(current_path).to eq('/dashboard/items')
      end
  end
end
