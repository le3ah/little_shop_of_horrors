require "rails_helper"

describe "Admin Order Cancel" do
  before :each do
    @u = create(:user)
    @m = create(:user, role: 1)
    @a = create(:user, role: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)

    @i_1 = create(:item, user: @m)
    @i_2 = create(:item, user: @m)

    @o = create(:order, user: @u)
    @c_o = create(:completed_order, user: @u)

    @oi_1 = create(:order_item, order: @o, item: @i_2)
    @oi_2 = create(:fulfilled_order_item, order: @o, item: @i_1)
    @oi_3 = create(:fulfilled_order_item, order: @o, item: @i_2)
  end

  it 'shows button to cancel only pending orders' do
    visit admin_user_path(@u.id)

    expect(page).to have_selector(:link_or_button, "Cancel", count: 1)

    click_button "Cancel"

    expect(current_path).to eq(admin_user_path(@u.id))
    expect(page).to_not have_selector(:link_or_button, "Cancel")
  end

  it 'does same behavior when cancelling as if user cancelled' do
    visit admin_user_path(@u.id)
    expect(page).to have_content("pending")
    prev_inv = [@i_1.inventory, @i_2.inventory]

    click_button "Cancel"

    @o.reload
    @i_1.reload
    @i_2.reload

    expect(@o.status).to eq("cancelled")
    expect(page).to have_content("cancelled")

    @o.order_items.each do |o_i|
      o_i.reload
      expect(o_i.fulfilled).to be_falsy
    end
    expect(@i_1.inventory).to eq(prev_inv[0] + @oi_2.quantity)
    expect(@i_2.inventory).to eq(prev_inv[1] + @oi_3.quantity)
    expect(page).to have_content("Order has been cancelled.")
  end
end
