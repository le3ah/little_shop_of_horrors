describe "user can't login with bad creds" do
    it "should show error flash if incorrect login" do
        user = create(:user)

        visit root_path
        click_on "login"

        expect(current_path).to eq(login_path)

        fill_in "email", with: user.email
        click_on "submit"

        expect(page).to_not have_content("Welcome, #{user.name}")
        expect(page).to have_content("Registered User Login")
        expect(page).to have_content("Oh no!")
    end
end
