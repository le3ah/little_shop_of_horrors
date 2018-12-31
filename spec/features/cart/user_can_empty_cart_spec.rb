require "rails_helper"

describe "Emptying Cart" do
  context 'as a visitor or regular user' do
    before :each do
      user = create(:user)
      item = create(:item, user_id: user.id)
      item_2 = create(:item, user_id: user.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit item_path(item)
      click_button "Add to Cart"
      visit item_path(item_2)
      click_button "Add to Cart"

      visit cart_path
    end

    it 'should redirect to cart_path when clicking empty cart' do
      click_button "Empty Cart"

      expect(current_path).to eq(cart_path)
    end

    it 'should remove items from cart when clicking empty cart' do
      click_button "Empty Cart"

      expect(page).to have_content("Your cart is empty!")
    end

    it 'should show 0 items in nav bar after clicking empty cart' do
      click_button "Empty Cart"

      within '.nav' do
        expect(page).to have_content("Shopping Cart (0)")
      end
    end
  end
end
