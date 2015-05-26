require 'spec_helper'

describe "Viewing todo_items" do
	let!(:todo_list){Todo.create(title: "Grocery List", description: "Groceries")}
	it "displays no items when the todo list is empty" do
		visit "/todos"
		within "#todo_#{todo_list.id}" do
			click_link "List Items"
		end

		expect(page).to have_content("TodoItems#index")
	end

end