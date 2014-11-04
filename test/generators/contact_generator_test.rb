require 'test_helper'
require 'generators/adminpanel/contact/contact_generator'

class ContactGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::ContactGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def test_the_generation_of_the_adminpanel_setup_file
    run_generator
    assert_file 'app/models/contact.rb'
  end

  def test_runs_without_errors
    assert_nothing_raised do
      run_generator
    end
  end

end
