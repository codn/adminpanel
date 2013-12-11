require "spec_helper"

describe "Section pages" do
	subject {page}

	let(:user) { Factory(:user) }
	before do 
		visit adminpanel.signin_path
		valid_signin(user)
	end
	
	describe "index" do
		let(:section) { Factory(:section_with_gallery) }
		before do
			visit adminpanel.sections_path
		end

		it { should have_link("i", adminpanel.section_path(section)) }
		it { should have_link("i", adminpanel.edit_section_path(section)) }
	end

	describe "show" do
		describe "with gallery" do
			let(:section) { Factory(:section_with_gallery) }
			let(:image) { Factory(:image_section, :foreign_key => section.id) }
			# let(:image2) { Factory(:image_section, :foreign_key => section.id) }
			# let(:image3) { Factory(:image_section, :foreign_key => section.id) }

			before do
				visit adminpanel.section_path(section)
				image.file = image.file

		    it { should have_title(section.name.humanize) }
		    it { should have_content(section.description) }
			it { should have_link("i", adminpanel.edit_section_path(section)) }
		end
	end
end