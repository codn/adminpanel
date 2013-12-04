require 'spec_helper'

describe Adminpanel::Gallery do
	before do
		@gallery = Adminpanel::Gallery.new(
			:file => "Test file"
			)
	end

	subject { @gallery }

	it { should respond_to(:file) }

	describe "when file is not present" do
		before {@gallery.file = " "}
		it {should_not be_valid}
	end
end