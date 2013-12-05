require "spec_helper"

describe "Categories" do
	subject {page}

	let(:user) { Factory(:user) }
	before do 
		visit adminpanel.signin_path
		valid_signin(user)
	end
	
	describe "categories index" do
		let(:category) { Factory(:category) }
		before do
			visit adminpanel.categories_path
		end

		it { should have_link(I18n.t("category.new"), adminpanel.new_category_path)}
		it { should have_link("i", adminpanel.category_path(category)) }
		it { should have_link("i", adminpanel.edit_category_path(category)) }
	end

	describe "create category" do
		before { visit adminpanel.new_category_path }

		it { should have_title(I18n.t("category.new")) }

		describe "with invalid information" do
			before { find("form#new_category").submit_form! }

			it { should have_title(I18n.t("category.new")) }
			it { should have_selector("div#alerts") }
		end

		describe "with valid information" do
			before do
				fill_in "category_name", :with => "category name"
				find("form#new_category").submit_form!
			end

			it { should have_content(I18n.t("category.success"))}
		end
	end
end