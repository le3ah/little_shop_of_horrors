require "rails_helper"

describe "User Order Cancel" do
  context "as a registered user with a pending order" do
    before :each do
      @u = create(:user)
      @m = create(:user, role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u)

      @i_1 = create(:item, user: @m)
      @i_2 = create(:item, user: @m)

      @o = create(:order, user: @u)
      @c_o = create(:completed_order, user: @u)

      @oi_1 = create(:fulfilled_order_item, order: @c_o, item: @i_1)

      @oi_2 = create(:order_item, order: @o, item: @i_2)
      @oi_3 = create(:fulfilled_order_item, order: @o, item: @i_1)
      @oi_4 = create(:fulfilled_order_item, order: @o, item: @i_2)
    end

    it 'should show link to cancel only pending orders' do
      visit profile_order_path(@o.id)

      expect(page).to have_selector(:link_or_button, "Cancel Order")

      visit profile_order_path(@c_o.id)
      expect(page).to_not have_selector(:link_or_button, "Cancel Order")
    end
  end
end
