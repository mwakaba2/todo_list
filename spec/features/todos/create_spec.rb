require 'spec_helper'

describe "Creating todos" do
	it "redirects to the todo list index page on success" do
		visit "/todos"
		click_link "New Todo"
		expect(page).to have_content("New Todo")

		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "This is what I'm doing today"
		click_button "Create Todo"

		expect(page).to have_content("My todo list")
	end

	it "displays an error if the todo list has no title" do
		expect(Todo.count).to eq(0)
		visit "/todos"
		click_link "New Todo"
		expect(page).to have_content("New Todo")

		fill_in "Title", with: ""
		fill_in "Description", with: "This is what I'm doing today"
		click_button "Create Todo"

		expect(page).to have_content("error")
		expect(Todo.count).to eq(0)

		visit "/todos"
		expect(page).to_not have_content("This is what I'm doing today")	

	end
	it "displays an error if the todo list has a title less than 3 characters" do
		expect(Todo.count).to eq(0)
		visit "/todos"
		click_link "New Todo"
		expect(page).to have_content("New Todo")

		fill_in "Title", with: "Hi"
		fill_in "Description", with: "This is what I'm doing today"
		click_button "Create Todo"

		expect(page).to have_content("error")
		expect(Todo.count).to eq(0)

		visit "/todos"
		expect(page).to_not have_content("This is what I'm doing today")	

	end

	it "displays an error if the todo list has no description" do
		expect(Todo.count).to eq(0)
		visit "/todos"
		click_link "New Todo"
		expect(page).to have_content("New Todo")

		fill_in "Title", with: "Grocery List"
		fill_in "Description", with: ""
		click_button "Create Todo"

		expect(page).to have_content("error")
		expect(Todo.count).to eq(0)

		visit "/todos"
		expect(page).to_not have_content("This is what I'm doing today")	

	end
	it "displays an error if the todo list has a description less than 3 characters" do
		expect(Todo.count).to eq(0)
		visit "/todos"
		click_link "New Todo"
		expect(page).to have_content("New Todo")

		fill_in "Title", with: "Grocery List"
		fill_in "Description", with: "fo"
		click_button "Create Todo"

		expect(page).to have_content("error")
		expect(Todo.count).to eq(0)

		visit "/todos"
		expect(page).to_not have_content("This is what I'm doing today")	

	end
end