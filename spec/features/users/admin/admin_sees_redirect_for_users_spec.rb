require "rails_helper"

describe "Admin merchant/user show page redirect" do
  before :each do
    @u = create(:user)
    @m = create(:user, role: 1)
    @a = create(:user, role: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@a)
  end

  it 'redirects to admin_user when visiting admin_merchant if id matches a default user' do

    visit admin_merchant_path(@u)

    expect(current_path).to eq(admin_user_path(@u))
  end

  it 'redirects to admin_merchant when visiting admin_user if id matches a merchant' do

    visit admin_user_path(@m)

    expect(current_path).to eq(admin_merchant_path(@m))
  end
end
