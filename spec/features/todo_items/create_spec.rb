require 'spec_helper'

describe "Adding todo_items" do
	let!(:todo_list){Todo.create(title: "Grocery List", description: "Groceries")}
	
	def visit_todo_list(list)
		visit "/todos"
		within "#todo_#{list.id}" do
			click_link "List Items"
		end
	end

	it "is successful with valid content" do
		visit_todo_list(todo_list)

		click_link "New Todo Item"
		fill_in "Content", with: "Milk"
		click_button "Save"

		expect(page).to have_content("Added todo list item.")
		within("ul.todo_items") do
			expect(page).to have_content("Milk")
		end
	end

	it "fails with no content" do
		visit_todo_list(todo_list)

		click_link "New Todo Item"
		fill_in "Content", with: ""
		click_button "Save"

		within("div.flash") do
			expect(page).to have_content("There was a problem adding that todo list item.")	
		end

		expect(page).to have_content("Content can't be blank")
	end

	it "fails with content less than 2 characters" do
		visit_todo_list(todo_list)

		click_link "New Todo Item"
		fill_in "Content", with: "1"
		click_button "Save"

		within("div.flash") do
			expect(page).to have_content("There was a problem adding that todo list item.")	
		end

		expect(page).to have_content("Content is too short")
	end
end
