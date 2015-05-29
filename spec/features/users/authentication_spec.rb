require "spec_helper"

describe "Loggin in" do
	it "logs the user in and goes to the todo lists " do
		User.create(first_name: "Mariko", last_name: "Wakabayashi", email: "mariko@teamtreehouse.com", password:"123", password_confirmation: "123")
		visit new_user_session_path
		fill_in "Email Address", with:"mariko@teamtreehouse.com"
		fill_in "Password", with: "123"
		click_button "Log In"

		expect(page).to have_content("Todo Lists")
		expect(page).to have_content("Thanks for logging in!")
	end
	it "displays the email address in the event of a failed login" do
		visit new_user_session_path
		fill_in "Email Address", with: "mariko@teamtreehouse.com"
		fill_in "Password", with: "incorrect"
		click_button "Log In"

		expect(page).to have_content("Please check your email and password")
		expect(page).to have_field("Email Address", with:"mariko@teamtreehouse.com")
	end

end