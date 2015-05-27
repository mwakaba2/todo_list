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
end
