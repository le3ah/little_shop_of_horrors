describe "As an admin" do
  context "when i visit the admin index page" do
    before(:each) do 
        @admin = create(:user, role:2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        @user1 = create(:user)
        @user2 = create(:user)
        @merchant = create(:user, role: 1)

        visit root_path   
        click_on 'Users'
    end 

    it "can see all default users" do
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@user2.name)
        save_and_open_page
        expect(page).to have_content(@user2.created_at.to_date)
        expect(page).to have_button("Enable") 
        expect(page).to_not have_content(@merchant.name)

        within("#user-#{@user1.id}") do
            click_button('Enable')
            @user1.reload
        end
        within("#user-#{@user1.id}") do
            expect(page).to have_button("Disable") 
        end
    end

    it 'can click on a users name and link to its respective show page' do 
        click_on(@user1.name)

        expect(current_path).to eq(admin_user_path(@user1))
    end
  end
end
