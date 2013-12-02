require 'spec_helper'
require "support/active_record"

describe Adminpanel::Section do
	before do
		@section = Adminpanel::Section.new(
			:description => "Test description for product",
			:file => "example.png",
			:has_image => true,
			:key => "example_key",
			:has_description => true
		)
	end

	subject { @section }

	it { should respond_to(:description) }
	it { should respond_to(:file) }	
	it { should respond_to(:has_image) }	
	it { should respond_to(:key) }
	it { should respond_to(:name) }
	it { should respond_to(:has_description) }	

	describe "when key is telephone and has less than 10 chars" do
		before {@section.key = "telephone"}
		before {@section.description = "1" * 9}
		it {should_not be_valid}
	end	

	describe "when key is telephone and has more than 10 chars" do
		before {@section.key = "telephone"}
		before {@section.description = "1" * 11}
		it {should_not be_valid}
	end	

	describe "when key is telephone and has 10 chars" do
		before {
			@section.key = "telephone"
			@section.description = "1" * 10
		}
		it {@section.description.length.should eql(10)}
	end	

	describe "when key is blank" do
		before {@section.key = " "}
		it {should_not be_valid}
	end	

	describe "when name is blank" do
		before {@section.name = " "}
		it {should_not be_valid}
	end	

	describe "when description is blank" do
		before {@section.description = " "}
		it {should_not be_valid}
	end	
end