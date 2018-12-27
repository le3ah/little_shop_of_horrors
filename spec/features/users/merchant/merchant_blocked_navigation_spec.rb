require "rails_helper"

describe "Visitor Blocked Navigation" do
  before :each do
    @m = create(:user, role: 1)
    @u = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m)
  end

  it 'should block visitors from profile paths' do
    visit profile_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit profile_edit_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)
  end

  it 'should block visitors from cart path' do
    visit cart_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)
  end

  it 'should block visitors from admin paths' do
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
