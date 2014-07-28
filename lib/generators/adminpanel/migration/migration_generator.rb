require 'rails/generators/active_record'
require 'generators/adminpanel/resource/resource_generator_helper'
require 'generators/adminpanel/migration/migration_generator_helper'

module Adminpanel
  class MigrationGenerator < ActiveRecord::Generators::Base
    include ResourceGeneratorHelper
    include MigrationGeneratorHelper

    source_root File.expand_path("../templates", __FILE__)
    desc "Generate a migration files and updates the model and controller"
    argument :fields, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"

    def change_field_aliases
      fields.each do |attribute|
        type = attribute.split(':').second
        case type
        when 'wysiwyg'
          fields.delete(attribute)
          fields << attribute.split(':').first + ':' + 'text'
        end
      end
    end

    def generate_migration
      parameters = fields
      parameters.delete_if do |pair|
        if pair.split(':').second == 'has_many'
          puts "migrations aren't supported yet, sorry :(, but you can do a pull request"
          true
        else
          false
        end
      end
      invoke :migration, [migration_name, parameters]
    end

    def inject_attributes_into_file
      inject_into_file(
        "app/models/adminpanel/#{resource_migrating}.rb",
        after: '      ['
      ) do
        indent ("\n" + get_attribute_hash + ','), 8
      end
    end

    def puts_messages
      puts "don't forget to migrate your database"
    end
  end
end
