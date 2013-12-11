include ActionDispatch::TestProcess

Factory.define :user, :class => Adminpanel::User do |user|
	user.name "test user"
	user.email "email@test.com"
	user.password "123456"
	user.password_confirmation "123456"
end

Factory.define :category, :class => Adminpanel::Category do |category|
	category.name "test category"
end

Factory.define :product, :class => Adminpanel::Product do |product|
	product.name "test product"
	product.brief "very little description"
	product.description "this is a little longer description, can be very long"
	product.association :category, :factory => :category
end

Factory.define :gallery, :class => Adminpanel::Gallery do |gallery|
	gallery.file { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'hipster.jpg'), 'image/jpeg') }
end

Factory.define :image_section, :class => Adminpanel::Image do |image|
	image.model "Section"
	image.file { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'hipster.jpg'), 'image/jpeg') }
end

Factory.define :section_with_gallery, :class => Adminpanel::Section do |section|
	section.key "key"
	# section.description "<p>description</p>"
	section.has_image true
	section.has_description false
	section.name "section_name"
end