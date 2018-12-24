require "rails_helper"

describe "Editing Cart" do
  context 'as a visitor or logged in user' do
    context 'when there are items in the cart' do
      before :each do
        user = create(:user, role: 1)
        @item = create(:item, user_id: user.id)
        @item_2 = create(:item, user_id: user.id, inventory: 2)

        visit item_path(@item)
        click_button "Add to Cart"
        visit item_path(@item_2)
        click_button "Add to Cart"
        visit item_path(@item_2)
        click_button "Add to Cart"

        visit cart_path
      end

      it 'has a button that removes an item' do
        expect(page).to have_selector(:link_or_button, "Remove", count: 2)
        click_button "rem-cart-item-0"

        expect(current_path).to eq(cart_path)
        expect(page).to_not have_content("#{@item.name} 1")
        expect(page).to have_content("Your cart has been updated")
      end

      it 'has a button that increments an item quantity' do
        expect(page).to have_selector(:link_or_button, "+", count: 2)
        click_button "plus-cart-item-0"

        expect(current_path).to eq(cart_path)
        expect(page).to have_content("#{@item.name} 2")
        expect(page).to have_content("Your cart has been updated")
      end

      it 'has a button that decrements an item quantity' do
        expect(page).to have_selector(:link_or_button, "-", count: 2)
        click_button "minus-cart-item-1"

        expect(current_path).to eq(cart_path)
        expect(page).to have_content("#{@item_2.name} 1")
        expect(page).to have_content("Your cart has been updated")
      end

      it "can't increment item quantity past merchant's inventory" do
        expect(page).to have_content("#{@item_2.name} 2")
        click_button "plus-cart-item-1"

        expect(page).to have_content("#{@item_2.name} 2")
        expect(page).to have_content("Not enough item quantity to fulfill that amount")
      end

      it 'automatically removes item when quantity reaches 0' do
        expect(page).to have_content("#{@item.name} 1")
        click_button "minus-cart-item-0"

        expect(page).to_not have_content("#{@item.name}")
        expect(page).to have_content("Your cart has been updated")
      end
    end
  end
end
