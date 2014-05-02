include ActionDispatch::TestProcess
FactoryGirl.define do

	factory :user, :class => Adminpanel::User do
		name 'test user'
		email 'email@test.com'
		password '123456'
		password_confirmation '123456'
		group_id 1
	end

	factory :group, :class => Adminpanel::Group do
		name 'Admin'
	end

	factory :product, :class => Adminpanel::Product do
		price "12392.2"
		name "very little description"
		description "this is a little longer description, can be very long"
	end

	factory :gallery, :class => Adminpanel::Gallery do
		file { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'hipster.jpg'), 'image/jpeg') }
	end

	factory :section_with_gallery, :class => Adminpanel::Section do
		key 'key'
		# description "<p>description</p>"
		has_image true
		has_description false
		name 'section_name'
		page 'index'
	end

	factory :image_section, :class => Adminpanel::Image do |image|
		file { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'hipster.jpg'), 'image/jpeg') }
	end

	factory :category, :class => Adminpanel::Category do
		name 'Test Category'
		model 'Product'
	end

	factory :photo, :class => Adminpanel::Photo do
		file { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'hipster.jpg'), 'image/jpeg') }
	end

	factory :mug, :class => Adminpanel::Mug do
		name 'super mug'
		number 2
	end
end
