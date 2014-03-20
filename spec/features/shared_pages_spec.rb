require 'spec_helper'

describe 'shared pages' do
	subject {page}

	let(:user) { Factory(:user) }
	before do
		visit adminpanel.signin_path
		valid_signin(user)
	end

	context 'when visiting' do
		describe 'index' do
			let(:product) { Factory(:product) }
			before do
				visit adminpanel.products_path
			end

			it { should have_link(Adminpanel::Product.display_name, adminpanel.new_product_path)}
			it { should have_link('i', adminpanel.product_path(product)) }
			it { should have_link('i', adminpanel.edit_product_path(product)) }
		end

		describe 'new' do
			let(:category){ Factory(:category) }
			before do
				category.id = 1 #to force instantiation and id.
				visit adminpanel.new_product_path
			end

			it { should have_title(I18n.t("action.create") + " " + Adminpanel::Product.display_name) }

			describe "with invalid information" do
				before { find("form#new_resource").submit_form! }

				it { should have_title(I18n.t("action.create") + " " + Adminpanel::Product.display_name) }
				it { should have_selector("div#alerts") }
			end

			describe "with valid information" do
				before do
					fill_in "product_name", :with => "product name"
					fill_in "product_price", :with => "855.5"
					find(:css, "#product_category_ids_[value='1']").set(true)
					find(:xpath, "//input[@id='description-field']").set "<p>a little longer text</p>"
					find("form#new_resource").submit_form!
				end

				it { should have_content(I18n.t("action.save_success"))}
				it { Adminpanel::Categorization.count.should equal(1)}
			end
		end

		describe "edit" do
			let(:category){ Factory(:category) }
			let(:product){ Factory(:product) }

			before do
				category.id = 1 #to force instantiation and id.
				product.category_ids = ["1"]
				visit adminpanel.edit_product_path(product)
			end

			it { should have_title(I18n.t("action.update") + " " + Adminpanel::Product.display_name) }

			describe "with invalid information" do
				before do
					fill_in "product_name", :with => ""
					fill_in "product_price", :with => ""
					find("form#edit_resource").submit_form!
				end

				it { should have_title(I18n.t("action.update") + " " + Adminpanel::Product.display_name) }
				it { should have_selector("div#alerts") }
			end

			describe "with same information" do
				before do
					find("form#edit_resource").submit_form!
				end

				it { should have_content(I18n.t("action.save_success"))}
			end

			describe "with valid information" do
				before do
					find(:css, "#product_category_ids_[value='1']").set(true)
					fill_in "product_name", :with => "product name"
					fill_in "product_price", :with => "855.5"
					find(:xpath, "//input[@id='description-field']").set "<p>a little longer text</p>"
					find("form#edit_resource").submit_form!
				end

				it { should have_content(I18n.t("action.save_success"))}
			end
		end

		describe "show" do
			let(:product) { Factory(:product) }
			let(:photo) { Factory(:photo) }

			before do
				photo.product_id = product.id
				visit adminpanel.product_path(product)
			end

			it { page.should have_selector("div", :text => product.name) }
			it { page.should have_selector("div", :text => product.price) }
			it { page.should have_selector("div", :text => product.description) }
			it { should have_content("#{I18n.t("Gallery")}: #{Adminpanel::Product.display_name}")}
			it { should have_link("i", adminpanel.edit_product_path(product)) }
		end
	end
end
