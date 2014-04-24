require 'spec_helper'


describe 'Section pages' do
	subject { page }

	let(:user) { get_user }
	before do
		Adminpanel::Section.delete_all
		visit adminpanel.signin_path
		valid_signin_as_admin(user)
	end

	describe 'index' do
		let!(:section) { FactoryGirl.create(:section_with_gallery) }
		before do
			visit adminpanel.sections_path
		end

		it { should have_link('i', adminpanel.section_path(section)) }
		it { should have_link('i', adminpanel.edit_section_path(section)) }
	end

	describe 'show' do
		describe 'with gallery' do
			let(:section) { FactoryGirl.create(:section_with_gallery) }

			before do
				visit adminpanel.section_path(section)
			end

	    it { should have_content(section.description) }
			it { should have_link('i', adminpanel.edit_section_path(section)) }
		end
	end
end
