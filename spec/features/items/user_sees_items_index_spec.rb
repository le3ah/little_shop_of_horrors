require "rails_helper"

describe 'Items Index Page' do
  context 'as any kind of user' do
    before :each do
      m_1 = create(:user, role: 1)

      m_2 = create(:user, role: 1)

      @i_1 = m_1.items.create(
        name: 'Flower Pot',
        description: 'Messy Pot',
        thumbnail: 'plant_1',
        price: 4,
        inventory: 5,
        enabled: true
      )

      @i_2 = m_2.items.create(
        name: 'Orchid sauce',
        description: 'Juicy sauce',
        thumbnail: 'plant_2',
        price: 2,
        inventory: 12
      )

      @i_3 = m_1.items.create(
        name: 'Cactus',
        description: 'Messy Pot',
        thumbnail: 'bad_path',
        price: 4,
        inventory: 5,
        enabled: true
      )

      visit items_path
    end

    it 'should show enabled item information' do
      within "#item-image-#{@i_1.id}" do
        expect(page).to have_css("##{@i_1.thumbnail}")
      end

      expect(page).to have_content(@i_1.name)
      expect(page).to have_content(@i_1.user.name)
      expect(page).to have_content("$#{@i_1.price}")
      expect(page).to have_content("Inventory: #{@i_1.inventory}")
    end

    it 'should not show disabled item information' do
      expect(page).to_not have_content(@i_2.name)
      expect(page).to_not have_content(@i_2.thumbnail)
      expect(page).to_not have_content(@i_2.user.name)
      expect(page).to_not have_content("$#{@i_2.price}")
      expect(page).to_not have_content("Inventory: #{@i_2.inventory}")
    end

    it 'should link to item show through item name' do
      click_link "#{@i_1.name}"
      expect(current_path).to eq(item_path(@i_1))
    end

    it 'should link to item show through item thumbnail' do
      click_link "item-image-#{@i_1.id}"
      expect(current_path).to eq(item_path(@i_1))
    end

    it 'should render default image if there is no image' do
      within "#item-image-#{@i_3.id}" do
        expect(page).to have_css("#no_img")
      end
    end
  end
end
