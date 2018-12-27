require "rails_helper"

describe "Admin Blocked Navigation" do
  before :each do
    @m = create(:user, role: 1)
    @u = create(:user)
    @a = create(:user, role: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)
  end

  it 'should block admin from profile paths' do
    visit profile_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit profile_edit_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)
  end

  it 'should block admin from cart path' do
    visit cart_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)
  end

  it 'should block admin from dashboard paths' do
    visit dashboard_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)

    visit dashboard_items_path
    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page.status_code).to eq(404)
  end
end
