ENV['RAILS_ENV'] ||= 'test'
require 'rails'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/emoji' #emoji output
# require 'minitest/debugger' if ENV['DEBUG'] # for deubgging


load Rails.root.join('db', 'schema.rb')

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting

  #fixtures live inside the dummy app

  fixtures :all

  # Add more helper methods to be used by all tests here...
end
