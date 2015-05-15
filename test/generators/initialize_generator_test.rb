require 'test_helper'
require 'generators/adminpanel/initialize/initialize_generator'

class InitializeGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::InitializeGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def after_setup
    Dir.mkdir Rails.root.join('tmp', 'generators', 'config')
    File.open Rails.root.join('tmp', 'generators', 'config', 'routes.rb'), 'w' do |f|
      f.puts "Rails.application.routes.draw do \n"
      f.puts "# lot of routes \n"
      f.puts "end"
    end
  end

  def test_the_generation_of_initial_migration
    run_generator
    assert_migration 'db/migrate/create_adminpanel_tables'
  end

  def test_the_generation_of_the_adminpanel_setup_file
    run_generator
    assert_file 'config/initializers/adminpanel_setup.rb'
  end

  def test_mount_of_adminpanel
    run_generator
    assert_file 'config/routes.rb', /mount Adminpanel/
  end

  def test_the_generation_of_the_section_uploader
    run_generator
    assert_file 'app/uploaders/adminpanel/section_uploader.rb'
  end

  def test_the_not_generation_of_files
    run_generator %w( -u true -m true -p true  )
    assert_no_file 'config/initializers/adminpanel_setup.rb'
    assert_no_migration 'db/migrate/create_adminpanel_tables'
    assert_no_file 'app/uploaders/adminpanel/section_uploader.rb'
  end

  def test_runs_without_errors
    assert_nothing_raised do
      run_generator
    end
  end

end
