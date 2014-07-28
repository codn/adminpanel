require 'test_helper'
require 'generators/adminpanel/resource/resource_generator'

class ResourceGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::ResourceGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def test_default_not_generation_of_gallery
    run_generator %w(
      post
      name
      description:wysiwyg
      number:float
    )
    assert_no_file 'app/models/adminpanel/postfile.rb'
    assert_no_migration 'db/migrate/create_adminpanel_postfiles.rb'
  end

  def test_generation_of_gallery
    run_generator %w(
      post
      name
      description:wysiwyg
      number:float
      --no-skip-gallery
    )
    assert_file 'app/models/adminpanel/postfile.rb'
    assert_migration 'db/migrate/create_adminpanel_postfiles.rb'
  end

  # def test_initializer_update
  #   run_generator %w(
  #     post
  #     name
  #     description:wysiwyg
  #     number:float
  #     -g=false
  #   )
  #   assert_file(
  #     'config/adminpanel_setup.rb',
  #     /:posts,/
  #   )
  # end

  def test_controller_generation
    run_generator %w(
      post
      name
      description:wysiwyg
      number:float
      flag:boolean
      quantity:integer
      date:datepicker
      --no-skip-gallery
    )
    assert_file(
      'app/controllers/adminpanel/posts_controller.rb',
      /params.require\(:post\).permit/,
      /:name/,
      /:description/,
      /:number/,
      /:flag/,
      /:quantity/,
      /:date/,
      /{ postfiles_attributes: \[:id, :file, :_destroy\] }/
    )
  end

  def test_model_generation
    run_generator %w(
      post
      name
      description:wysiwyg
      number:float
      flag:boolean
      quantity:integer
      date:datepicker
      categories:has_many
      --no-skip-gallery
    )
    assert_file(
      'app/models/adminpanel/post.rb',
      /include Adminpanel::Base/,
      /mount_images :postfiles/,
      # form_fields generated correctly
      /'description' => {/,
      /'type' => 'wysiwyg_field',/,
      /'name' => {/,
      /'type' => 'text_field',/,
      /'number' => {/,
      /'type' => 'text_field',/,
      /'flag' => {/,
      /'type' => 'boolean',/,
      /'quantity' => {/,
      /'type' => 'number_field',/,
      /'date' => {/,
      /'type' => 'datepicker',/,
      /'postfiles' => {/,
      /'type' => 'adminpanel_file_field',/,
      /'category_ids' => {/,
      /'type' => 'has_many'/,
      /'model' => 'Adminpanel::/
    )
  end

  def test_creating_a_categorization_resource
    run_generator %w(
      categorization
      category:belongs_to
      product:belongs_to
    )
    assert_no_file 'app/controllers/adminpanel/categorizations_controller.rb'
    assert_no_file 'app/controllers/adminpanel/categorizationfiles.rb'
    assert_file(
      'app/models/adminpanel/categorization.rb',
      /belongs_to :product/,
      /belongs_to :category/
    )
  end

  def test_that_runs_without_errors
    assert_nothing_raised do
      run_generator ["doll", ['name']]
    end
  end
end
