require 'spec_helper'

describe Adminpanel::Category do
	before do
		@category = Adminpanel::Category.new(
			:name => "Test category"
			)
	end

	subject { @category}

	it {should respond_to(:name) }

	describe "when name is not present" do
		before {@category.name = " "}
		it {should_not be_valid}
	end
end








































