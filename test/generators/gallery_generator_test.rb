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
    assert_file(
      'app/models/adminpanel/productfile.rb',
      /mount_uploader :file, ProductfileUploader/
    )
    assert_file(
      'app/uploaders/adminpanel/productfile_uploader.rb'
    )
  end

  def test_the_generation_of_the_snake_cases_migration
    run_generator ['snake_case']
    assert_migration(
      'db/migrate/create_adminpanel_snake_casefiles.rb',
      /t.integer :snake_case_id/,
      /create_table :adminpanel_snake_casefiles/
    )
    assert_file(
      'app/models/adminpanel/snake_casefile.rb',
      /mount_uploader :file, SnakeCasefileUploader/
    )
    assert_file(
      'app/uploaders/adminpanel/snake_casefile_uploader.rb',
      /class SnakeCase/
    )
  end

  def test_runs_without_errors
    assert_nothing_raised do
      run_generator ['Testname']
    end
  end

end
