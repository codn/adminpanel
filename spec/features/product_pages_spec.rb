require "spec_helper"

describe "Products" do
	subject {page}

	let(:user) { Factory(:user) }
	before do 
		visit adminpanel.signin_path
		valid_signin(user)
	end
	
	describe "products index" do
		let(:product) { Factory(:product) }
		before do
			visit adminpanel.products_path
		end

		it { should have_link(I18n.t("product.new"), adminpanel.new_product_path)}
		it { should have_link("i", adminpanel.product_path(product)) }
		it { should have_link("i", adminpanel.edit_product_path(product)) }
	end

	describe "create product" do
		let(:category) { Factory(:category) }
		before do 
			category.id = 1 #to force instantiation so it becomes available in the select
			visit adminpanel.new_product_path
		end

		it { should have_title(I18n.t("product.new")) }

		describe "with invalid information" do
			before { find("form#new_product").submit_form! }

			it { should have_title(I18n.t("product.new")) }
			it { should have_selector("div#alerts") }
		end

		describe "with valid information" do
			before do
				fill_in "product_name", :with => "product name"
				fill_in "product_brief", :with => "little brief"
				find(:xpath, "//input[@id='description-field']").set "a little longer text"
				select category.name, :from => "product_category_id"
				find("form#new_product").submit_form!
			end

			it { should have_content(I18n.t("product.success"))}
		end

		describe
	end
end