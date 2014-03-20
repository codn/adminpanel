require 'rails/generators/active_record'
module Adminpanel
  module Generators
    class GalleryGenerator < ActiveRecord::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Generate the resource files necessary to use a model"

      # argument :reference_model,
      #   :aliases => "-m",
      #   :type => :string,
      #   :require => true,
      #   :desc => 'Choose the model that you want the uploader to belong_to'

      def create_model
        template 'gallery_template.rb', "app/models/adminpanel/#{lower_name}.rb"
      end

      def create_uploader
        template 'uploader.rb', "app/uploader/adminpanel/#{lower_name}_uploader.rb"
      end

      def create_migration
        migration_template 'gallery_migration.rb', "db/migrate/create_adminpanel_#{lower_name.pluralize}_table.rb"
        puts "don't forget to add the form_field, the relationship and #{lower_name}s_attributes it to attr_accessible"
      end

    private
      def reference_name
        name.singularize.downcase
      end

      def class_name
        "#{lower_name.capitalize}"
      end

      def lower_name
        "#{name.singularize.downcase}file"
      end
    end
  end
end
