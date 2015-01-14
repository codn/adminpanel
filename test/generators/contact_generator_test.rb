require 'test_helper'
require 'generators/adminpanel/contact/contact_generator'

class ContactGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::ContactGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def test_the_generation_of_the_attr_accessor_params
    run_generator %w(body email name age country)
    assert_file(
      'app/models/contact.rb',
      /attr_accessor :email, :name, :age, :country, :body/
    )
  end

  def test_generation_of_validations
    run_generator %w(body email name age country)
    assert_file(
      'app/models/contact.rb',
      /validates_presence_of :email/,
      /validates_presence_of :body/,
      /validates_presence_of :age/,
      /validates_presence_of :name/,
      /validates_presence_of :country/
    )
  end

  def test_generation_of_email_validations
    run_generator %w(email body)
    assert_file(
      'app/models/contact.rb',
      /# validations for email/,
      /VALID_EMAIL_REGEX = \/\\A\[\\w\+\\-.\]\+@\[a-z\\d\\-.\]\+\\.\[a-z\]\+\\z\/i/,
      /validates_format_of :email, with: VALID_EMAIL_REGEX, message: "\#{I18n.t\('model.attributes.email'\)} \#{I18n.t\('activerecord.errors.messages.invalid'\)}"/
    )
  end

  def test_generation

  end

  def test_runs_without_errors
    assert_nothing_raised do
      run_generator
    end
  end

end
