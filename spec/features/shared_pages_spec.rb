require "spec_helper"

describe "shared pages" do
	subject {page}

	let(:user) { Factory(:user) }
	before do 
		visit adminpanel.signin_path
		valid_signin(user)
	end
	
	describe "index" do
		let(:product) { Factory(:product) }
		before do
			visit adminpanel.products_path
		end

		it { should have_link(Adminpanel::Product.display_name, adminpanel.new_product_path)}
		it { should have_link("i", adminpanel.product_path(product)) }
		it { should have_link("i", adminpanel.edit_product_path(product)) }
	end

	describe "new" do
		before do 
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
				find(:xpath, "//input[@id='description-field']").set "<p>a little longer text</p>"
				find("form#new_resource").submit_form!
			end

			it { should have_content(I18n.t("action.save_success"))}
		end
	end

	describe "edit" do
		let(:product){ Factory(:product) }

		before do 
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
		let(:image) { Factory(:image_resource) }

		before do
			image.foreign_key = product.id
			visit adminpanel.product_path(product)
		end

		it { page.should have_selector("div", :text => product.name) }
		it { page.should have_selector("div", :text => product.price) }
		it { page.should have_selector("div", :text => product.description) }
		it { should have_content("#{I18n.t("Gallery")}: #{Adminpanel::Product.display_name}")}
		it { should have_link("i", adminpanel.edit_product_path(product)) }
		# it { page.should have_css(:img, :text => image.file.to_s) }
		# it { page.should have_selector("img[@href = '#{image.file}']") }
		# it { page.should have_selector("img[@href = 'asdfsad#{image.file}']") }
	end
end