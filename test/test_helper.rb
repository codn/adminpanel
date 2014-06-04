ENV['RAILS_ENV'] ||= 'test'
require 'rails'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/emoji' #emoji output
require 'capybara/rails'
require 'minitest/unit' #mocha
require 'mocha/mini_test' #mocha
require 'capybara/poltergeist'


Capybara.current_driver = :poltergeist

load Rails.root.join('db', 'schema.rb')

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection


class ActiveSupport::TestCase
  #fixtures live inside the dummy app
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ViewCase < ActionView::TestCase
  include Capybara::DSL
  include Capybara::Assertions
  include Rails.application.routes.url_helpers

  def teardown
    Capybara.reset_session!
    Capybara.current_driver = :poltergeist
  end

  protected
  def login(password = 'foobar')
    fill_in 'inputEmail', with: adminpanel_users(:valid).email
    fill_in 'inputPassword', with: password #pass is foobar
    click_button I18n.t('authentication.new-session')
  end
end
