class TodoItem < ActiveRecord::Base
  belongs_to :todo
  validates :content, presence: true
  validates :content, length: {minimum: 2}
end
