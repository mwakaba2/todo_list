class TodoItemsController < ApplicationController
  def index
  	@todo_list = Todo.find(params[:todo_id])
  end
end
