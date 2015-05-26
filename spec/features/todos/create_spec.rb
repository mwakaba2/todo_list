require 'spec_helper'

describe "Creating todos" do
	def create_todo_list(options={})
		options[:title] ||= "My todo list"
		options[:description] ||= "This is what I'm doing today"
		visit "/todos"
		click_link "New Todo"
		expect(page).to have_content("New Todo")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo"
		
	end

	it "redirects to the todo list index page on success" do
		create_todo_list

		expect(page).to have_content("My todo list")
	end

	it "displays an error if the todo list has no title" do
		expect(Todo.count).to eq(0)
		create_todo_list title: ""
		expect(page).to have_content("error")
		expect(Todo.count).to eq(0)

		visit "/todos"
		expect(page).to_not have_content("This is what I'm doing today")	

	end
	it "displays an error if the todo list has a title less than 3 characters" do
		expect(Todo.count).to eq(0)
		create_todo_list title: "Hi"
		expect(page).to have_content("error")
		expect(Todo.count).to eq(0)

		visit "/todos"
		expect(page).to_not have_content("This is what I'm doing today")	

	end

	it "displays an error if the todo list has no description" do
		expect(Todo.count).to eq(0)
		create_todo_list description: ""
		expect(page).to have_content("error")
		expect(Todo.count).to eq(0)

		visit "/todos"
		expect(page).to_not have_content("This is what I'm doing today")	

	end
	it "displays an error if the todo list has a description less than 3 characters" do
		expect(Todo.count).to eq(0)
		create_todo_list description: "fo"

		expect(page).to have_content("error")
		expect(Todo.count).to eq(0)

		visit "/todos"
		expect(page).to_not have_content("This is what I'm doing today")	

	end
end