require 'spec_helper'

describe 'Gallery pages' do
	let(:gallery) { FactoryGirl.build(:gallery) }
	let(:user) { FactoryGirl.build(:user) }

	subject { page }

	before do
		gallery.save
		visit adminpanel.signin_path
		valid_signin_as_admin(user)
		clean_uploads_folder
	end

	describe 'galleries' do
		before do
			visit adminpanel.galleries_path
		end

		it { should have_link(I18n.t('gallery.new'), adminpanel.new_gallery_path)}
		it { should have_link('i', adminpanel.gallery_path(gallery)) }
		it { should have_link('i', adminpanel.edit_gallery_path(gallery)) }
		it { should have_link('i', adminpanel.move_to_better_gallery_path(gallery)) }
		it { should have_link('i', adminpanel.move_to_worst_gallery_path(gallery)) }
	end

	context 'when creating' do
    let(:gallery_1) { FactoryGirl.build(:gallery) }
    let(:gallery_2) { FactoryGirl.build(:gallery) }
    let(:gallery_3) { FactoryGirl.build(:gallery) }

		before do
			Adminpanel::Gallery.delete_all
			gallery_1.save
		end

		describe 'a single image' do
			it { gallery_1.position.should eq 1 }
		end

		describe '3 images' do

			before do
				gallery_2.save
				gallery_3.save
			end
			it { gallery_2.position.should eq 2 }
			it { gallery_3.position.should eq 3 }
			describe "when moving down the image in position 1" do
				before do
					gallery_1.move_to_worst_position
					gallery_2.reload
					gallery_3.reload
				end

				it { gallery_1.move_to_worst_position.should eq true}
				it { gallery_3.move_to_worst_position.should eq false}
				it { gallery_1.position.should eq 2}
				it { gallery_2.position.should eq 1}
				it { gallery_3.position.should eq 3}

				after do
					gallery_1.position = 1
					gallery_2.position = 2
					gallery_3.position = 3
				end
			end

			describe "when moving up the image in position 2" do
				before do
					gallery_2.move_to_better_position
					gallery_1.reload
					gallery_3.reload
				end

				it { gallery_1.move_to_better_position.should eq true}
				it { gallery_2.move_to_better_position.should eq false}
				it { gallery_1.position.should eq 2}
				it { gallery_2.position.should eq 1}
				it { gallery_3.position.should eq 3}

				after do
					gallery_1.position = 1
					gallery_2.position = 2
					gallery_3.position = 3
				end
			end

			describe "when deleting the image in position 1" do
				before do
					gallery_1.destroy
					gallery_2.reload
					gallery_3.reload
				end

				it { gallery_2.position.should eq 1}
				it { gallery_3.position.should eq 2}
			end
		end
	end

	describe "show" do
		before do
			visit adminpanel.gallery_path(gallery)
		end

		it { page.should have_selector("img[src='#{gallery.file_url(:thumb)}']") }
	end
end
