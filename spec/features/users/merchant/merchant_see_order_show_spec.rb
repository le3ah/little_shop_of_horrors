require "rails_helper"

describe "Merchant Order Show Page" do
  context 'when merchant visits order show from dashboard' do
    before :each do
      @m = create(:user, role: 1)
      m_2 = create(:user, role: 1)
      @i_1 = create(:item, user: @m)
      @i_2 = create(:item, user: m_2)


      @u = create(:user)

      @o = create(:order)
      @oi_1 = create(:order_item, order: @o, item: @i_1)
      @oi_2 = create(:order_item, order: @o, item: @i_2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m)
      visit dashboard_path
    end

    it "shows customer's name and address" do
      click_link "Order ID: #{@o.id}"
      expect(current_path).to eq(dashboard_order_path(@o))

      expect(page).to have_content("Name: #{@o.user.name}")
      expect(page).to have_content("Address: #{@o.user.address}")
    end

    it "only shows items from current merchant's inventory" do
      click_link "Order ID: #{@o.id}"

      expect(page).to_not have_link("Name: #{@i_2.name}")
      expect(page).to_not have_content("#{@i_2.thumbnail}")
      expect(page).to_not have_content("Price #{@oi_2.price}")
      expect(page).to_not have_content("Quantity Ordered: #{@oi_2.quantity}")
    end

    it 'shows item information for this order' do
      click_link "Order ID: #{@o.id}"

      expect(page).to have_link("Name: #{@i_1.name}")
      expect(current_path).to eq(dashboard_item_path(@i_1))

      expect(page).to have_content("#{@i_1.thumbnail}")
      expect(page).to have_content("Price #{@oi_1.price}")
      expect(page).to have_content("Quantity Ordered: #{@oi_1.quantity}")
    end
  end
end
