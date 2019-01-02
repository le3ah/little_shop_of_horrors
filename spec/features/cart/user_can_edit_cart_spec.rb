require "rails_helper"

describe "Editing Cart" do
  context 'as a visitor or logged in user' do
    context 'when there are items in the cart' do
      before :each do
        user = create(:user)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
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
  
        expect(page).to_not have_content("#{@item.name}")

        within "#cart_id_#{@item_2.id}" do
          expect(page).to have_content("2")
        end
        expect(page).to have_content("Your cart has been updated")
      end

      it 'has a button that increments an item quantity' do
        expect(page).to have_selector(:link_or_button, "+", count: 2)
        within "#cart_id_#{@item.id}" do
          expect(page).to have_content("1")
        end
        click_button "plus-cart-item-0"

        expect(current_path).to eq(cart_path)
        within "#cart_id_#{@item.id}" do
          expect(page).to have_content("2")
        end
        expect(page).to have_content("Your cart has been updated")
      end

      it 'has a button that decrements an item quantity' do
        expect(page).to have_selector(:link_or_button, "-", count: 2)
        within "#cart_id_#{@item_2.id}" do
          expect(page).to have_content("2")
        end
        click_button "minus-cart-item-1"
        
        expect(current_path).to eq(cart_path)
        within "#cart_id_#{@item_2.id}" do
          expect(page).to have_content("1")
        end
        expect(page).to have_content("Your cart has been updated")
      end

      it "can't increment item quantity past merchant's inventory" do
        within "#cart_id_#{@item_2.id}" do
          expect(page).to have_content("2")
        end
        click_button "plus-cart-item-1"

        within "#cart_id_#{@item_2.id}" do
          expect(page).to have_content("2")
        end
        expect(page).to have_content("Not enough item quantity to fulfill that amount")
      end

      it 'automatically removes item when quantity reaches 0' do
        within "#cart_id_#{@item.id}" do
          expect(page).to have_content("1")
        end
        click_button "minus-cart-item-0"

        expect(page).to_not have_content("#{@item.name}")
        expect(page).to have_content("Your cart has been updated")
      end
    end
  end
end
