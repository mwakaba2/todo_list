require "spec_helper"

describe "Signing up" do
	it "allows a user to sign up for a site and creates the object in the database" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"

		fill_in "First Name", with: "Mariko"
		fill_in "Last Name", with: "Wakabayashi"
		fill_in "Email", with: "mariko@teamtreehouse.com"
		fill_in "Password", with: "12345"
		fill_in "Password (again)", with: "12345"
		click_button "Sign Up"

		expect(User.count).to eq(1)
	end
end