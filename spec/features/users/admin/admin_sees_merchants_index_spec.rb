require "rails_helper" 

RSpec.describe 'as an Admin' do 

    context "admin can see a merchant's dashboard" do
        
        it "can view the merchant's index page" do 
            admin = User.create(name:"sweet christmas", email: 'test@test.com', password:"hownow", role: 2, 
                address: "123 road street", city: "denver", zip:12345, state: "co")

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

            visit admin_merchants_path

            expect(page).to have_content('All da merchants')
        end 
        
        it "can view the merchants show page and see the merchant's dashboard" do
            admin = User.new(name:"sweet christmas", email: 'test@test.com', password:"hownow", role: 2, 
                address: "123 road street", city: "denver", zip:12345, state: "co")
            merchant = create(:user, role: 1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
            
            visit admin_merchants_path
            
            click_on("#{merchant.name}")
            
            expect(current_path).to eq(admin_merchant_path(merchant)) 
            expect(page).to have_content("Merchant Page") 
        end
        
        it "default user can't visit admin_merchants_path" do
            user = create(:user)
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

            visit admin_merchants_path

            expect(page).to_not have_content("All da merchants")
            expect(page).to have_content("The page you were looking for doesn't exist.") 
        end
        
        
    end
    
end 