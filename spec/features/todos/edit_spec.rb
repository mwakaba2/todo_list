require "spec_helper"

describe "Editing todo lists" do
	let!(:todo_list) {Todo.create(title: "Groceries", description: "Grocery List")}
	def update_todo_list(options={})
		options[:title] ||= "New Title"
		options[:description] ||= "New Description"
		visit "/todos"
		todo_list = options[:todo_list]
		within "#todo_#{todo_list.id}" do
			click_link "Edit"
		end
		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo"
	end

	it "updates a todo list with the correct title and description" do
		update_todo_list todo_list: todo_list,
										 title: "New Title",
										 description: "New Description"
		todo_list.reload

		expect(page).to have_content("Todo was successfully updated")
		expect(todo_list.title).to eq("New Title")
		expect(todo_list.description).to eq("New Description")
	end

	it "displays an error with no title" do
		update_todo_list todo_list: todo_list, title: ""
		title = todo_list.title
		todo_list.reload
		expect(todo_list.title).to eq(title)
		expect(page).to have_content("error")
	end

	it "displays an error with short title" do
		update_todo_list todo_list: todo_list, title: "HI"
		expect(page).to have_content("error")
	end

	it "displays an error with no description" do
		update_todo_list todo_list: todo_list, description: ""
		expect(page).to have_content("error")
	end

	it "displays an error with short description" do
		update_todo_list todo_list: todo_list, description: "fo"
		expect(page).to have_content("error")
	end
end