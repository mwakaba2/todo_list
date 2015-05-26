class CreateTodoItems < ActiveRecord::Migration
  def change
    create_table :todo_items do |t|
      t.references :todo, index: true
      t.string :content

      t.timestamps null: false
    end
    add_foreign_key :todo_items, :todos
  end
end
