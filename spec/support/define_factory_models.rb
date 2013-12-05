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