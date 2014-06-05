require 'test_helper'
require 'generators/adminpanel/gallery/gallery_generator'

class GalleryGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::GalleryGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def test_the_generation_of_the_productfiles_migration
    run_generator ['Product']
    assert_migration(
      'db/migrate/create_adminpanel_productfiles.rb',
      /t.integer :product_id/,
      /create_table :adminpanel_productfiles/
    )
  end

  def test_the_generation_of_the_productfile
    run_generator ['Product']
    assert_file(
      'app/models/adminpanel/productfile.rb',
      /mount_uploader :file, ProductfileUploader/
    )
  end

  def test_the_generation_of_the_productfile_uploader
    run_generator ['Product']
    assert_file(
      'app/uploaders/adminpanel/productfile_uploader.rb'
    )
  end

  def test_runs_without_errors
    assert_nothing_raised do
      run_generator
    end
  end

end
