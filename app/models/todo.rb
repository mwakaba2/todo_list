class Todo < ActiveRecord::Base
	validates :title, presence: true
	validates :title, length: {minimum: 3}
end
