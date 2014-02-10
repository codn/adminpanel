require "spec_helper"

describe "User pages" do
	subject {page}

	let(:user) { Factory(:user) }
	before do 
		visit adminpanel.signin_path
		valid_signin(user)
	end
	
	describe "index" do
		before do
			visit adminpanel.users_path
		end

		it { should have_link(I18n.t("user.new"), adminpanel.new_user_path)}
		it { should have_link("i", adminpanel.user_path(user)) }
		it { should have_link("i", adminpanel.edit_user_path(user)) }
	end

	describe "new" do
		before do 
			visit adminpanel.new_user_path
		end

		it { should have_title(I18n.t("user.new")) }

		describe "with invalid information" do
			before { find("form#new_user").submit_form! }

			it { should have_title(I18n.t("user.new")) }
			it { should have_selector("div#alerts") }
		end

		describe "with valid information" do
			before do
				fill_in "user_name", :with => "user_name"
				fill_in "user_email", :with => "user@example.com"
				fill_in "user_password", :with => "123456"
				fill_in "user_password_confirmation", :with => "123456"
				find("form#new_user").submit_form!
			end

			it { should have_content(I18n.t("user.success"))}
		end
	end
end