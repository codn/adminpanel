require 'spec_helper'

describe Adminpanel::Section do
	before do
		@section = Adminpanel::Section.new(
			:name => "Section name",
			:description => "Test description for index",
			:has_image => true,
			:key => "example_key",
			:has_description => true,
			:page => "index"
		)
	end

	subject { @section }

	it { should respond_to(:description) }
	it { should respond_to(:has_image) }	
	it { should respond_to(:key) }
	it { should respond_to(:name) }
	it { should respond_to(:has_description) }	
	it { should respond_to(:page) }	

	describe "when key is telephone and has less than 10 chars" do
		before do 
			@section.key = "telephone"
			@section.description = "1" * 9
		end
		it { @section.valid? eq false}
	end	

	describe "when key is telephone and has more than 10 chars" do
		before do 
			@section.key = "telephone"
			@section.description = "1" * 11
		end
		it { @section.valid? eq false}
	end	

	describe "when key is telephone and has 10 chars" do
		before do
			@section.key = "telephone"
			@section.description = "1" * 10
		end
		it { @section.valid? eq true}

	end	

	describe "when key is blank" do
		before {@section.key = " "}
		it { @section.valid? eq false}
	end	

	describe "when name is blank" do
		before {@section.name = " "}
		it { @section.valid? eq false}
	end	

	describe "when description is blank" do
		before {@section.description = " "}
		it { @section.valid? eq false}
	end

	describe "default scope" do
		it { expect(Adminpanel::Section.scoped.to_sql).to eq Adminpanel::Section.reorder('').order('page ASC').to_sql}
	end
end