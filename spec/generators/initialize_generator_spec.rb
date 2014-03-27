require 'spec_helper'
require 'generators/adminpanel/initialize/initialize_generator'

describe Adminpanel::Generators::InitializeGenerator do
  destination File.expand_path("../../dummy/tmp", __FILE__)

  before do
    Rails::Generators.options[:rails][:orm] = :active_record
  end

  after do
    prepare_destination
  end

  describe 'with no arguments' do
    before do
      prepare_destination
      run_generator
    end

    it 'should generate the initial migration' do
      migration_file('db/migrate/create_adminpanel_tables.rb').should be_a_migration
    end

    it 'should generate the adminpanel_setup file' do
      file('config/initializers/adminpanel_setup.rb').should exist
    end

    it 'should generate the categories migration' do
      migration_file('db/migrate/create_adminpanel_categories_table.rb').should be_a_migration
    end

    it 'should generate the category file' do
      file('app/models/adminpanel/category.rb').should exist
    end

    it 'should generate the section uploader' do
      file('app/uploaders/adminpanel/section_uploader.rb').should exist
    end
  end

  describe 'with arguments -c true -u true -m true -p true' do
    before do
      prepare_destination
      run_generator %w(-c true -u true -m true -p true)
    end

    it 'should\'t generate the adminpanel_setup' do
      file('config/initializers/adminpanel_setup.rb').should_not exist
    end

    it 'should\'t generate the initial migration' do
      migration_file('db/migrate/create_adminpanel_categories_table.rb').should_not exist
    end

    it 'should\'t genearte the section uploader' do
      file('app/uploaders/adminpanel/section_uploader.rb').should_not exist
    end

    it 'should\'t generate the categories migration' do
      migration_file('db/migrate/create_adminpanel_categories_table.rb').should_not exist
    end

    it 'should\'t generate the category file' do
      file('app/models/adminpanel/category.rb').should_not exist
    end
  end
end
