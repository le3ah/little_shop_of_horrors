require "rails_helper"

describe "Merchants Index Page" do
  context 'as a visitor' do
    before :each do
      @merch = create(:user, role: 1, enabled: false)
      @merch_2 = create(:user, role: 1, created_at: 2.days.ago)
      visit merchants_path
    end

    it 'should show merchant information' do
      expect(page).to have_content(@merch_2.name)
      expect(page).to have_content(@merch_2.city)
      expect(page).to have_content(@merch_2.state)
      expect(page).to have_content(@merch_2.created_at)
    end

    it 'should not show inactive merchant information' do
      expect(page).to_not have_content(@merch.name)
      expect(page).to_not have_content(@merch.city)
      expect(page).to_not have_content(@merch.state)
      expect(page).to_not have_content(@merch.created_at)
    end
  end
end
