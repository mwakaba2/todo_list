require 'spec_helper'

describe Todo do
	it {should have_many(:todo_items)}	
end