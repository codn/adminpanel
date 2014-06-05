require 'rails/generators/active_record'
module Adminpanel
  class GalleryGenerator < ActiveRecord::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    desc "Generate the resource files necessary to use a model"

    def generate_model
      template 'gallery_template.rb', "app/models/adminpanel/#{lower_name}.rb"
    end

    def generate_uploader
      template 'uploader.rb', "app/uploaders/adminpanel/#{lower_name}_uploader.rb"
    end

    def generate_migration
      migration_template(
        'gallery_migration.rb',
        "db/migrate/create_adminpanel_#{lower_name.pluralize}.rb"
      )
      puts "don't forget to add the form_field, the relationship and #{lower_name}s_attributes it to the permited params"
    end

  private
    def reference_name
      name.singularize.downcase
    end

    def lower_name
      "#{reference_name}file"
    end

    def class_name
      "#{lower_name.capitalize}"
    end

  end
end
