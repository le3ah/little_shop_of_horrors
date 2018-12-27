require "rails_helper"

describe "Default User Blocked Navigation" do
  before :each do
    @m = create(:user, role: 1)
    @u = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@u)
  end
  
  it 'should block default users from dashboard paths' do
    visit dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit dashboard_items_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)
  end

  it 'should block default users from admin paths' do
    visit admin_merchants_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit admin_merchant_path(@m)
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit admin_users_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit admin_user_path(@u)
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)
  end
end
