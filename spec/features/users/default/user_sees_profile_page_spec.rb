require 'rails_helper'

describe 'Default User Profile Page' do
  before :each do
    @u = create(:user)
    @m = create(:user, role: 1)

    @o_1 = create(:order, user: @u, created_at: 3.days.ago, updated_at: 2.days.ago)
    @o_2 = create(:completed_order, user: @u, created_at: 4.days.ago, updated_at: 3.days.ago)
    @o_3 = create(:cancelled_order, user: @u, created_at: 5.days.ago, updated_at: 1.days.ago)

    @i_1 = create(:item, enabled: true, user: @m)
    @i_2 = create(:item, enabled: true, user: @m)
    @i_3 = create(:item, enabled: true, user: @m)

    create(:order_item, order: @o_1, item: @i_1)
    create(:order_item, order: @o_2, item: @i_2)
    create(:order_item, order: @o_3, item: @i_3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u)

    visit profile_path
  end

  it 'displays user info on profile page' do
    expect(current_path).to eq profile_path
    expect(page).to have_content("Welcome, #{@u.name}!")
    expect(page).to have_content("Email: #{@u.email}")
    expect(page).to have_content("Address: #{@u.address}")
    expect(page).to have_content("City: #{@u.city}")
    expect(page).to have_content("State: #{@u.state}")
    expect(page).to have_content("Zip: #{@u.zip}")
    expect(page).to have_link('Edit Profile', href: profile_edit_path)
  end

  context 'when user has ordered items' do
    it 'should link to order show page' do
      click_link "View Order ##{@o_1.id}"
      expect(current_path).to eq(profile_order_path(@o_1))

      visit profile_path

      click_link "View Order ##{@o_2.id}"
      expect(current_path).to eq(profile_order_path(@o_2))

      visit profile_path

      click_link "View Order ##{@o_3.id}"
      expect(current_path).to eq(profile_order_path(@o_3))
    end

    it 'should show order information' do
      within "#order-#{@o_1.id}" do
        expect(page).to have_content("View Order ##{@o_1.id}")
        expect(page).to have_content("Created at: #{@o_1.created_at}")
        expect(page).to have_content("Updated at: #{@o_1.updated_at}")
        expect(page).to have_content("Status: #{@o_1.status}")
        expect(page).to have_content("Item Count: #{@o_1.quantity_of_order}")
        expect(page).to have_content("Grand Total: #{@o_1.grand_total}")
      end

      within "#order-#{@o_2.id}" do
        expect(page).to have_content("View Order ##{@o_2.id}")
        expect(page).to have_content("Created at: #{@o_2.created_at}")
        expect(page).to have_content("Updated at: #{@o_2.updated_at}")
        expect(page).to have_content("Status: #{@o_2.status}")
        expect(page).to have_content("Item Count: #{@o_2.quantity_of_order}")
        expect(page).to have_content("Grand Total: #{@o_2.grand_total}")
      end

      within "#order-#{@o_3.id}" do
        expect(page).to have_content("View Order ##{@o_3.id}")
        expect(page).to have_content("Created at: #{@o_3.created_at}")
        expect(page).to have_content("Updated at: #{@o_3.updated_at}")
        expect(page).to have_content("Status: #{@o_3.status}")
        expect(page).to have_content("Item Count: #{@o_3.quantity_of_order}")
        expect(page).to have_content("Grand Total: #{@o_3.grand_total}")
      end
    end
  end
end
