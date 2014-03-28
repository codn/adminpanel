require 'spec_helper'
require 'generators/adminpanel/gallery/gallery_generator'

describe Adminpanel::Generators::GalleryGenerator do
  destination File.expand_path("../../dummy/tmp", __FILE__)

  before do
    Rails::Generators.options[:rails][:orm] = :active_record
  end

  # after do
  #   prepare_destination
  # end

  describe 'with "product" as argument' do
    before do
      prepare_destination
      run_generator %w(Product)
    end

    it 'should generate the productfile migration' do
      migration_file('db/migrate/create_adminpanel_productfiles_table.rb').should
        be_a_migration
    end


    it 'should migrate the correct fields' do
      migration_file('db/migrate/create_adminpanel_productfiles_table.rb').should(
        contain(/t.integer :product_id/) &&
        contain(/create_table :adminpanel_productfiles/)
      )
    end

    it 'should generate the productfile model with uploader and attr_accessible' do
      file('app/models/adminpanel/productfile.rb').should(
        contain(/attr_accessible :product_id, :file/) &&
        contain(/mount_uploader :file, ProductfileUploader/)
      )
    end

    it 'should generate the productfile model with uploader and attr_accessible' do
      file('app/models/adminpanel/productfile.rb').should exist
    end

    it 'should the produfile uploader' do
      file('app/uploaders/adminpanel/productfile_uploader.rb').should exist
    end
  end
end
