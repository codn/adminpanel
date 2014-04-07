require 'spec_helper'
require 'support/test_database'

describe 'shared pages' do
	subject { page }

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

		context 'product' do

			describe 'new' do
				let(:category){ Factory(:category) }
				before do
					category.id = 1 #to force instantiation and id.
					visit adminpanel.new_product_path
				end

				it { should have_title(I18n.t("action.create") + " " + Adminpanel::Product.display_name) }

				it 'should have add remote category button' do
					should have_selector(
						'a.btn-info',
						:text => I18n.t(
							'other.add',
							:model => Adminpanel::Category.display_name
						)
					)
				end

				describe 'submtting with invalid information' do
					before do
						find("form#new_resource").submit_form!
					end

					it { should have_title(I18n.t("action.create") + " " + Adminpanel::Product.display_name) }
					it { should have_selector("div#alerts") }
				end

				# describe 'opening the remote form modal' do
				# 	before do
				# 		page.find("a##{Adminpanel::Category.name.demodulize.downcase}-modal-link").click
				# 	end
				#
				# 	it 'should have modal with correct #modal-title' do
				# 		page.should have_selector(
				# 		:css,
				# 		'h3#modal-title',
				# 		:content => I18n.t('other.add', :model => Adminpanel::Category.display_name)
				# 		)
				# 	end
				#
				# 	it 'should have the modal with the correct fields' do
				# 		should have_selector("input#category_name")
				# 	end

					# describe 'sending the resource remotely with invalid information' do
					# 	before do
					# 		find('#new-Category-button').click
					# 	end
					# 	it 'should display error message' do
					# 		page.should have_selector("div#alerts")
					# 	end
					# end

				# end

				describe 'submitting with valid information' do
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
