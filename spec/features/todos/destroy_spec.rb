require "spec_helper"

describe "Deleting todo lists" do
	let!(:todo_list) {Todo.create(title: "Groceries", description: "Grocery List")}
	it "is successful when deleting a todo_list" do
		visit "/todos"

		within "#todo_#{todo_list.id}" do
			click_link "Destroy"
		end

		expect(page).to_not have_content(todo_list.title)
		expect(Todo.count).to eq(0)
	end
end

