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

  private
    def reference_name
      name.singularize.downcase
    end

    def lower_name
      "#{reference_name}file"
    end

    def class_name
      "#{reference_name.camelize}file"
    end

  end
end
