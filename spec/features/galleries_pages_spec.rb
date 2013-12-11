require "spec_helper"

describe "Gallery pages" do
	subject {page}

	let(:user) { Factory(:user) }
	before do 
		visit adminpanel.signin_path
		valid_signin(user)
		clean_uploads_folder
	end
	
	describe "galleries" do
	let(:gallery) { Factory(:gallery) }
		before do
			visit adminpanel.galleries_path
		end

		it { should have_link(I18n.t("gallery.new"), adminpanel.new_gallery_path)}
		it { should have_link("i", adminpanel.gallery_path(gallery)) }
		it { should have_link("i", adminpanel.edit_gallery_path(gallery)) }
	end

	describe "new" do
		before do 
			visit adminpanel.new_gallery_path
		end

		it { should have_title(I18n.t("gallery.new")) }

		describe "with invalid information" do
			before { find("form#new_gallery").submit_form! }

			it { should have_title(I18n.t("gallery.new")) }
			it { should have_selector("div#alerts") }
		end

		describe "with valid information" do
			before do
				attach_file('gallery_file', File.join(Rails.root, '/app/assets/images/hipster.jpg'))
				find("form#new_gallery").submit_form!
			end

			it { should have_content(I18n.t("gallery.success"))}
			it { File.exists? File.join(Rails.root, '/public/uploads/gallery/file/1/thumb_hipster.jpg') }
		end
	end

	describe "show" do
		let(:gallery) { Factory(:gallery) }
		before do
			visit adminpanel.gallery_path(gallery)
		end

		it { page.should have_selector("img", :src => gallery.file_url) }
	end
end