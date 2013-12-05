def valid_signin(user)
	fill_in "inputEmail", :with => user.email
	fill_in "inputPassword", :with => user.password
 	click_button "signin-button"
end

RSpec::Matchers::define :have_title do |text|
  match do |page|
    Capybara.string(page.body).has_selector?('title', :text => text)
  end
end