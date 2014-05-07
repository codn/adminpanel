require 'spec_helper'

describe 'Shared pages' do
	subject { page }


	let(:user) { get_user }
	let!(:product) { FactoryGirl.create(:product) }
	let!(:category){ FactoryGirl.create(:category) }
	let!(:photo) { FactoryGirl.create(:photo) }
	let!(:mug) { FactoryGirl.create(:mug) }

	before do
		Adminpanel::User.delete_all
		visit adminpanel.signin_path
		valid_signin_as_admin(user)
	end

	after do
		Adminpanel::User.delete_all
	end

	describe 'mugs#index excluding every rest action but index' do
		before do
			visit adminpanel.mugs_path
		end

		it 'should not have create mug button' do
			should_not have_link('a', href:'/adminpanel/tazas/new')
		end
		it 'should not have show or destroy button' do
			should_not have_link('a', href:'/adminpanel/tazas/1')
		end
		it 'should not have edit button' do
			should_not have_link('a', href:'/adminpanel/tazas/1/edit')
		end
	end


	describe 'index' do
		before do
			visit adminpanel.products_path
		end

		it { should have_link(Adminpanel::Product.display_name, adminpanel.new_product_path)}
		it { should have_link('i', adminpanel.product_path(product)) }
		it { should have_link('i', adminpanel.edit_product_path(product)) }
	end

	describe 'new' do
		before do
			visit adminpanel.new_product_path
		end

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
				find("#new-Product-button").click
			end

			it { should have_title(I18n.t("action.create") + " " + Adminpanel::Product.display_name) }
			it 'should stay in products#new' do
				current_url.should eq adminpanel.new_product_url
			end
		end

		# describe 'submitting with valid information' do
		# 	before do
		# 		fill_in "product_name", :with => "product name"
		# 		fill_in "product_price", :with => "855.5"
		# 		find(:css, "#product_category_ids_[value='1']").set(true)
		# 		find(:xpath, "//input[@id='description-field']").set "<p>a little longer text</p>"
		# 		find("#new-Product-button").click
		# 	end
		#
		# 	# it { should have_content(I18n.t("action.save_success"))}
		# 	# it { expect(Adminpanel::Categorization.count).to eq(1)}
		# end
	end

	describe "edit" do

		before do
			product.category_ids = [category.id]
			visit adminpanel.edit_product_path(product)
		end

		it { should have_title(I18n.t("action.update") + " " + Adminpanel::Product.display_name) }

		describe "with invalid information" do
			before do
				fill_in "product_name", :with => ""
				fill_in "product_price", :with => ""
				find("#new-resource-button").click
			end

			it 'should stay to products#edit' do
				current_url.should eq adminpanel.edit_product_url(product)
			end
			it { should have_title(I18n.t("action.update") + " " + Adminpanel::Product.display_name) }
		end

	end

	describe 'show' do

		before do
			photo.product_id = product.id
			visit adminpanel.product_path(product)
		end

		it { page.should have_selector('div', :text => product.name) }
		it { page.should have_selector('div', :text => product.price) }
		it { page.should have_selector('div', :text => product.description) }
		it { should have_content("#{I18n.t("gallery.name")}: #{Adminpanel::Product.display_name}")}
		it { should have_link('i', adminpanel.edit_product_path(product)) }
	end
end
