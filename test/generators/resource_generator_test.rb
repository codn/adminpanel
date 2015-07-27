require 'test_helper'
require 'generators/adminpanel/resource/resource_generator'

class ResourceGeneratorTest < Rails::Generators::TestCase
  tests Adminpanel::ResourceGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  def after_setup
    # Create setup dynamically to test over it.
    Dir.mkdir Rails.root.join('tmp', 'generators', 'config')
    Dir.mkdir Rails.root.join('tmp', 'generators', 'config', 'initializers')
    File.open Rails.root.join('tmp', 'generators', 'config', 'initializers', 'adminpanel_setup.rb'), 'w' do |f|
      f.puts "Adminpanel.setup do |config| \n"
      f.puts "  config.displayable_resources = [ \n"
      f.puts "    :users,\n"
      f.puts "    :permissions\n"
      f.puts "  end\n"
      f.puts "end"
    end
  end


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

  def test_initializer_update
    run_generator %w(
      post
      name
      description:wysiwyg
      number:float
    )
    assert_file(
      'config/initializers/adminpanel_setup.rb',
      /:posts,/
    )
  end

  def test_controller_generation
    run_generator %w(
      post
      name
      description:wysiwyg
      number:float
      flag:boolean
      quantity:integer
      date:datepicker
      other_resource:has_many
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
      /{ other_resource_ids: \[\] }/,
      /{ postfiles_attributes: \[:id, :file, :_destroy\] }/
    )
  end

  def test_controller_with_underscore
    run_generator %w(
      a_underscored_resource
      name
    )
    assert_file(
      'app/controllers/adminpanel/a_underscored_resources_controller.rb',
      /class AUnderscoredResourcesController </
    )
  end

  def test_multiple_files
    run_generator %w(
      fily_resource
      pdf1:file
      pdf2:file
      pdf3:file
      img1:image
    )
    assert_file(
      'app/models/adminpanel/fily_resource.rb',
      /'pdf1' => {/,
      /'pdf2' => {/,
      /'pdf3' => {/,
      /mount_uploader :pdf1, FilyResourcePdf1Uploader/,
      /mount_uploader :pdf2, FilyResourcePdf2Uploader/,
      /mount_uploader :pdf3, FilyResourcePdf3Uploader/,
      /mount_uploader :img1, FilyResourceImg1Uploader/,
      /'type' => 'file_field'/,
    )
  end

  def test_model_generation
    run_generator %w(
      post
      name
      other_field:integer
      --no-skip-gallery
    )
    assert_file(
      'app/models/adminpanel/post.rb',
      /class Post </,
      /mount_images :postfiles/
    )
  end

  def test_model_with_undercore
    run_generator %w(
      admin_post
      name
      description:wysiwyg
      number:float
      flag:boolean
      avatar:image
      user:belongs_to
      quantity:integer
      date:datepicker
      categories:has_many
      --no-skip-gallery
    )
    assert_file(
      'app/models/adminpanel/admin_post.rb',
      /class AdminPost </,
      /include Adminpanel::Base/,
      /mount_images :admin_postfiles/,
      # form_attributes generated correctly
      /'description' => {/,
      /'type' => 'wysiwyg_field',/,
      /'name' => {/,
      /'type' => 'text_field',/,
      /'number' => {/,
      /'type' => 'text_field',/,
      /'flag' => {/,
      /'type' => 'boolean',/,
      /'avatar' => {/,
      /'type' => 'image_field',/,
      /'quantity' => {/,
      /'type' => 'number_field',/,
      /'date' => {/,
      /'user_id' => {/,
      /Adminpanel::User.all/,
      /'type' => 'date',/,
      /'admin_postfiles' => {/,
      /'type' => 'adminpanel_file_field',/,
      /'category_ids' => {/,
      /'type' => 'checkbox'/,
      /'options' => Proc.new { |object|/,
      /Adminpanel::Category.all/
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

  def test_generating_has_many_resource
    run_generator %w(
      blog
      name
      post:has_many
      categories:has_many
    )
    assert_file(
      'app/models/adminpanel/blog.rb',
      /'post_ids' => {/,
      /'type' => 'checkbox'/,
      /'options' => Proc.new { |object|/,
      /Adminpanel::Post.all/,
      /'category_ids' => {/,
      /'options' => Proc.new { |object|/,
      /Adminpanel::Category.all/
    )
  end

  def test_generating_with_single_attachment_file
    run_generator %w(
      monkey
      avatar:image
      user:belongs_to
    )
    assert_file(
      'app/models/adminpanel/monkey.rb',
      /def name/,
      /mount_uploader :avatar, MonkeyAvatarUploader/,
      /'avatar' => {/,
      /'type' => 'image_field'/
    )
    assert_file(
      'app/uploaders/adminpanel/monkey_avatar_uploader.rb',
      /class MonkeyAvatarUploader </
    )
  end

  def test_that_runs_without_errors
    assert_nothing_raised do
      run_generator ["doll", ['name']]
    end
  end
end
