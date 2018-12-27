require "rails_helper"

describe "Admin User Show" do
  it 'shows same information as user visiting their own profile' do
    u = create(:user)
    a = create(:user, role: 2)
    o = create(:order, user: u)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(a)

    visit admin_user_path(u)

    expect(page).to have_content("#{u.name}")
    expect(page).to have_content("Email: #{u.email}")
    expect(page).to have_content("Address: #{u.address}")
    expect(page).to have_content("City: #{u.city}")
    expect(page).to have_content("State: #{u.state}")
    expect(page).to have_content("Zip: #{u.zip}")
    expect(page).to have_content('Edit Profile')
    # probably a user story later - edit_admin_user_path
    # expect(page).to have_link('Edit Profile', href: edit_admin_user_path)

    # also most likely a story later
    # click_link "View Order ##{@o_1.id}"
    # expect(current_path).to eq(admin_order_path(@o_1))

    within "#order-#{o.id}" do
      expect(page).to have_content("View Order ##{o.id}")
      expect(page).to have_content("Created at: #{o.created_at}")
      expect(page).to have_content("Updated at: #{o.updated_at}")
      expect(page).to have_content("#{o.status}")
      expect(page).to have_content("#{o.quantity_of_order}")
      expect(page).to have_content("#{o.grand_total}")
      expect(page).to have_button("Cancel")
    end
  end

  it 'shows the same order data as the default user sees' do
    u = create(:user)
    a = create(:user, role: 2)
    o = create(:order, user: u)
    o_2 = create(:order, user: u)

    m = create(:user, role: 1)
    i_1 = create(:item, user: m)
    i_2 = create(:item, user: m)
    create(:order_item, order: o, item: i_1)
    create(:order_item, order: o, item: i_2)
    create(:order_item, order: o_2, item: i_1)
    create(:order_item, order: o_2, item: i_2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(a)

    visit admin_user_path(u)

    within "#order-#{o.id}" do
      expect(page).to have_content("View Order ##{o.id}")
      expect(page).to have_content("Created at: #{o.created_at}")
      expect(page).to have_content("Updated at: #{o.updated_at}")
      expect(page).to have_content("Status: #{o.status}")
      expect(page).to have_content("Item Count: #{o.quantity_of_order}")
      expect(page).to have_content("Grand Total: #{o.grand_total}")
      expect(page).to have_button("Cancel")
    end

    within "#order-#{o_2.id}" do
      expect(page).to have_content("View Order ##{o_2.id}")
      expect(page).to have_content("Created at: #{o_2.created_at}")
      expect(page).to have_content("Updated at: #{o_2.updated_at}")
      expect(page).to have_content("Status: #{o_2.status}")
      expect(page).to have_content("Item Count: #{o_2.quantity_of_order}")
      expect(page).to have_content("Grand Total: #{o_2.grand_total}")
      expect(page).to have_button("Cancel")
    end
  end
end
