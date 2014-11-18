require 'test_helper'
require 'generators/adminpanel/contact/dump_generator'

class DumpGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::DumpGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def test_the_generation_of_user_dump
    run_generator ['user']
  end

  def test_runs_without_errors
    assert_nothing_raised do
      run_generator ['user']
    end
  end

end
