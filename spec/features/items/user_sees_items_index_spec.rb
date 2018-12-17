require "rails_helper"

describe 'Items Index Page' do
  context 'as any kind of user' do
    before :each do
      m_1 = Merchant.create(
        name: "Bob's Burgers",
        email: "email@email.com",
        password: "1234password",
        role: 1,
        address: "12 Main st",
        city: "Town",
        state: "CO"
      )

      @i_1 = m_1.items.create(
        name: 'Burger',
        description: 'Juicy',
        thumbnail: 'thumbnail',
        price: 4,
        inventory: 5
      )

      @i_2 = m_1.items.create(
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
      expect(page).to have_content(@i_1.merchant.name)
      expect(page).to have_content(@i_1.price)
      expect(page).to have_content(@i_1.inventory)
    end

    it 'should not show disabled item information' do
      expect(page).to_not have_content(@i_2.name)
      expect(page).to_not have_content(@i_2.thumbnail)
      expect(page).to_not have_content(@i_2.merchant.name)
      expect(page).to_not have_content(@i_2.price)
      expect(page).to_not have_content(@i_2.inventory)
    end

    it 'should link to item show through item name' do

    end

    it 'should link to item show through item thumbnail' do

    end
  end
end
