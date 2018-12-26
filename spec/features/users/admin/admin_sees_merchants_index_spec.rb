require "rails_helper"

RSpec.describe 'as an Admin' do

    context "Admin can see a merchants index" do
        xit "can click link from nav to reach admin_merchants_path" do
          admin = create(:user, role: 2)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

          visit root_path
          click_link "Browse Merchants as Admin"

          expect(current_path).to eq(admin_merchants_path)
        end
        it "can visit and see data" do
            admin = create(:user, role:2)
            merchant = create(:user, role:1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

            visit admin_merchants_path

            expect(page).to have_content(merchant.name)
            expect(page).to have_content(merchant.city)
            expect(page).to have_content(merchant.state)

            click_on(merchant.name)

            expect(current_path).to eq(admin_merchant_path(merchant))
        end

        it "can enable and disable merchant status" do
            admin = create(:user, role:2)
            merchant1 = create(:user, role:1)
            merchant2 = create(:user, role:1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

            visit admin_merchants_path

            within("#merchant-#{merchant1.id}") do
                click_on("disable")
            end

            expect(current_path).to eq(admin_merchants_path)

            merchant1.reload

            within("#merchant-#{merchant1.id}") do
                expect(page).to have_button("enable")
            end
        end

    end


    context "admin can see a merchant's dashboard" do

        it "can view the merchant's index page" do
            admin = create(:user, role: 2)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

            visit admin_merchants_path

            expect(page).to have_content('All da merchants')
        end

        it 'can view the index page and see all of the merchants' do
            admin = create(:user, role: 2)
            merchant1 = create(:user, role:1)
            merchant2 = create(:user, role:1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

            visit admin_merchants_path

            expect(page).to have_content(merchant1.name)
            expect(page).to have_content(merchant2.name)
            expect(page).to have_content(merchant2.city)
            expect(page).to have_content(merchant2.state)
            expect(page).to have_content(merchant1.city)
            expect(page).to have_content(merchant1.state)

        end

        it "can view the merchants show page and see the merchant's dashboard" do
            admin = create(:user, role: 2)
            merchant = create(:user, role: 1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

            visit admin_merchants_path

            click_on("#{merchant.name}")

            expect(current_path).to eq("/admin/merchants/#{merchant.id}")
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
