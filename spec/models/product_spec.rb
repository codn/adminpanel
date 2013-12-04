require 'spec_helper'

describe Adminpanel::Product do
	before do
		@category = Adminpanel::Category.new(
			:name => "test category",
			:id => 1
		)
		@product = Adminpanel::Product.new(
			:description => "Test description for product",
			:name => "product name",
			:category_id => "1",
			:brief => "short description"
		)
	end

	subject { @product }

	it { should respond_to(:name) }
	it { should respond_to(:description) }
	it { should respond_to(:category_id) }
	it { should respond_to(:brief) }	

	describe "when product belongs to a category" do
		before {@category.save}
		after {@category.delete}
		it {@product.category.should eql(@category)}
	end	

	describe "when no name present" do
		before {@product.name = " "}
		it {should_not be_valid}
	end

	describe "when no description present" do
		before {@product.description = " "}
		it {should_not be_valid}
	end

	describe "when no category is present" do
		before {@product.category_id = " "}
		it {should_not be_valid}
	end

	describe "when no brief is present" do
		before {@product.brief = " "}
		it {should_not be_valid}
	end


end