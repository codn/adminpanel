require 'rails/generators/active_record'
require 'generators/adminpanel/resource/resource_generator_helper'

module Adminpanel
  class ResourceGenerator < ActiveRecord::Generators::Base
    include ResourceGeneratorHelper
    source_root File.expand_path('../templates', __FILE__)
    desc 'Generate the resource files necessary to use a model'
    class_option :'skip-gallery',
      :type => :boolean,
      :default => true,
      :desc => 'Choose if we shoud create the gallery for this resource, default: true (skip gallery)'

    argument :fields, :type => :array, :default => [], :banner => 'field[:type][:index] field[:type][:index]'

    def change_fields_aliases
      fields.each do |attribute|
        type = attribute.split(':').second
        case type
        when 'wysiwyg'
          fields.delete(attribute)
          fields << attribute.split(':').first + ':' + 'text'
        end
      end
    end

    def generate_model
  		template 'adminpanel_resource_template.rb', "app/models/adminpanel/#{resource_name}.rb"
    end

    def generate_controller
      if is_a_resource?
        template 'adminpanel_controller_template.rb', "app/controllers/adminpanel/#{pluralized_name}_controller.rb"
      end
    end

    def generate_migration
      parameters = fields
      parameters.delete_if{ |pair| pair.split(':').second == 'has_many' }
      parameters << 'created_at:datetime' << 'updated_at:datetime'
      invoke :migration, ["create_adminpanel_#{pluralized_name}", parameters]
    end

    def generate_gallery
      if has_gallery? && is_a_resource?
        invoke 'adminpanel:gallery', [resource_name]
      end
    end

    def add_resource_to_config
      if setup_is_found? && is_a_resource?
        inject_into_file 'config/initializers/adminpanel_setup.rb',
          after: 'config.displayable_resources = [' do
          indent "\n:#{pluralized_name},", 4
        end
      end
    end

    def print_messages
      puts "don't forget to restart your server and migrate db"
    end
  end
end
