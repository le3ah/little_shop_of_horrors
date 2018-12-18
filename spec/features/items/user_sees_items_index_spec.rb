require "rails_helper"

describe 'Items Index Page' do
  context 'as any kind of user' do
    before :each do
      m_1 = User.create!(
        name: "Bob's Burgers",
        email: "email@email.com",
        password: "1234password",
        role: 1,
        address: "12 Main st",
        city: "Town",
        zip: 92020,
        state: "CO"
      )

      @i_1 = m_1.items.create!(
        name: 'Burger',
        description: 'Juicy',
        thumbnail: 'thumbnail',
        price: 4,
        inventory: 5,
        enabled: true
      )

      @i_2 = m_1.items.create!(
        name: 'Burger sauce',
        description: 'Juicy sauce',
        thumbnail: 'thumbnail',
        price: 2,
        inventory: 12,
        enabled: false
      )

      visit items_path
    end

    it 'should show enabled item information' do
      expect(page).to have_content(@i_1.name)
      expect(page).to have_content(@i_1.thumbnail)
      expect(page).to have_content(@i_1.user.name)
      expect(page).to have_content(@i_1.price)
      expect(page).to have_content(@i_1.inventory)
    end

    it 'should not show disabled item information' do
      expect(page).to_not have_content(@i_2.name)
      expect(page).to_not have_content(@i_2.thumbnail)
      expect(page).to_not have_content(@i_2.user.name)
      expect(page).to_not have_content(@i_2.price)
      expect(page).to_not have_content(@i_2.inventory)
    end

    xit 'should link to item show through item name' do
      click_link "#{@i_2.name}"
      expect(current_path).to eq(item_path(@i_2))
    end

    xit 'should link to item show through item thumbnail' do
      click_link "image-#{@i_2.id}"
      expect(current_path).to eq(item_path(@i_2))
    end
  end
end
