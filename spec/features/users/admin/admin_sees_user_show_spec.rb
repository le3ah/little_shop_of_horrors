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
    end
  end
end
