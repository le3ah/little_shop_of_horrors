require "rails_helper"

describe "Editing Cart" do
  context 'as a visitor or logged in user' do
    context 'when there are items in the cart' do
      before :each do
        user = create(:user, role: 1)
        item = create(:item, user_id: user.id, inventory: 2)
        item_2 = create(:item, user_id: user.id)

        visit item_path(item)
        click_button "Add to Cart"
        visit item_path(item_2)
        click_button "Add to Cart"
        visit item_path(item_2)
        click_button "Add to Cart"

        visit cart_path
      end

      xit 'has a button to remove an item' do
        expect(page).to have_selector(:link_or_button, "Remove", count: 2)
        click_button "rem-cart-item-0"

        expect(current_path).to eq(cart_path)
        expect(page).to_not have_content("#{item.name} 1")
      end

      xit 'has a button to increment an item quantity' do
        expect(page).to have_selector(:link_or_button, "+", count: 2)
        click_button "plus-cart-item-0"

        expect(current_path).to eq(cart_path)
        expect(page).to have_content("#{item.name} 2")
      end

      xit "can't increment item quantity past merchant's inventory" do

      end

      xit 'has a button to decrement an item quantity' do
        expect(page).to have_selector(:link_or_button, "-", count: 2)
        click_button "minus-cart-item-0"

        expect(current_path).to eq(cart_path)
        expect(page).to have_content("#{item_2.name} 1")
      end

      xit 'automatically removes item when quantity reaches 0' do

      end
    end
  end
end
