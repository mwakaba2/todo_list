require 'spec_helper'

describe 'Forgotten Passwords' do
	let!(:user) {create(:user)}

	it "sends a user an email" do
		visit login_path
		click_link "Forgot Password"
		fill_in "Email", with: user.email
		expect {
			click_button "Reset Password"
		}.to change{ ActionMailer::Base.deliveries.size}.by(1)
	end

	it "resets the password by following the email link" do
		visit login_path
		click_link "Forgot Password"
		fill_in "Email", with: user.email
		click_button "Reset Password"
		open_email(user.email)
		current_email.click_link "http://"
		expect(page).to have_content("Change Your Password")

		fill_in "Password", with: "mynewpassword1"
		fill_in "Password (again)", with: "mynewpassword1"
		click_button "Change Password"
		expect(page).to have_content("Password Updated")
		expect(page.current_path).to eq(todo_lists_path)

		click_link "Log Out"
		expect(page).to have_content("You must be logged in to access that page.")
		visit login_path
		fill_in "Email", with: user.email
		fill_in "Password", with: "mynewpassword1"
		click_button "Log In"
		expect(page).to have_content("Thanks for logging in!")
	end
end