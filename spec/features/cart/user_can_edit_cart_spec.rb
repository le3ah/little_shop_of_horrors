require "rails_helper"

describe "Editing Cart" do
  context 'as a visitor or logged in user' do
    context 'when there are items in the cart' do
      before :each do
        user = create(:user, role: 1)
        item = create(:item, user_id: user.id)
        item_2 = create(:item, user_id: user.id)

        visit item_path(item)
        click_button "Add to Cart"
        visit item_path(item_2)
        click_button "Add to Cart"

        visit cart_path
      end

      it 'has a button to remove an item' do
        expect(page).to have_selector(:link_or_button, "Remove", count: 2)
        click_button "rem-cart-item-0"
        require "pry"; binding.pry
      end

      it 'has a button to increment an item quantity' do

      end

      it "can't increment item quantity past merchant's inventory" do

      end

      it 'has a button to decrement an item quantity' do

      end

      it 'automatically removes item when quantity reaches 0' do

      end
    end
  end
end
