describe 'admin can see specific links in the nav bar' do 
    it "can see specific admin links in the nav" do
        user = create(:user, name: "oh holy night", role:0)
        
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit merchants_path 
        
        within(".nav") do
            expect(page).to have_content("Profile")
            expect(page).to have_content("Orders")
            expect(page).to have_content("logout")
            expect(page).to have_content("Users") 
        end

        click_on('Profile')
        expect(current_path).to eq(profile_path)
        
        click_on('Orders')
        expect(current_path).to eq(profile_orders_path) 

        click_on('logout')
        expect(current_path).to eq(root_path)

        click_on('Users')
        expect(current_path).to eq(admin_users_path) 
    end
end
