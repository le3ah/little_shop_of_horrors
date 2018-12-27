require "rails_helper"

describe "Admin make User a Merchant" do
  before :each do
    @u = create(:user)
    @m = create(:user, role: 1)
    @a = create(:user, role: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)
  end

  it 'shows button to upgrade user account on user profile' do
    visit admin_user_path(@u)

    expect(page).to have_button("Upgrade User")
  end

  it 'redirects to admin_merchant and shows flash message after upgrading' do
    visit admin_user_path(@u)

    click_button "Upgrade User"

    expect(current_path).to eq(admin_merchant_path(@u))
    expect(page).to have_content("User has been updgraded to Merchant")
  end

  it 'persits user upgrade next time they login' do
    visit admin_user_path(@u)
    click_button "Upgrade User"

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
    visit login_path

    fill_in "email", with: @u.email
    fill_in "password", with: @u.password
    click_on "submit"

    expect(current_path).to eq(dashboard_path)
  end

  it 'only shows button to upgrade for admins' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u)
    visit profile_path
    expect(page).to_not have_button("Upgrade User")
  end

  it 'blocks navigation to non admins to routes used for upgrade' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u)
    visit admin_user_path(@u)
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m)
    visit admin_user_path(@u)
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)
  end
end
