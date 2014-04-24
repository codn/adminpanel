require 'spec_helper'

describe "Authentication" do

	subject { page }

	describe 'sign in page' do
	    before { visit adminpanel.signin_path }

	    it { should have_content(I18n.t("authentication.welcome")) }

	    it { expect(page).to have_title(I18n.t("Panel title")) }
	end

    describe 'signin' do
	    before { visit adminpanel.signin_path }

	    describe 'with invalid information' do
      	before do
          click_button 'signin-button'
        end

	    	it { expect(page).to have_title(I18n.t("Panel title")) }
      	it { should have_selector('div.alert.alert-error', :text => I18n.t('authentication.signin_error')) }
	    end

	    describe 'with valid information' do
	    	let(:user) { FactoryGirl.build(:user) }
	    	before do
	    		valid_signin_as_admin(user)
	    	end

	    	it { should have_selector('div.alert.alert-success', :text => I18n.t('authentication.signin_success')) }
	    	it { should have_selector('i.icon-off') }

	    	describe 'signing out' do
	    		before { click_link 'signout-button'}

	    		it { current_path.should == adminpanel.signin_path }
	    		it { expect(page).to have_title(I18n.t("Panel title")) }

	    	end
	    end
	end
end
