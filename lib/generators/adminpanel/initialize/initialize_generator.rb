require 'rails/generators/active_record'
module Adminpanel
  class InitializeGenerator < ActiveRecord::Generators::Base
    desc 'Generate the migrations necessary to start the gem'
    source_root File.expand_path("../templates", __FILE__)
    argument :name, type: :string, default: 'default', require: false
    class_option :'skip-section-uploader',
                  type: :boolean,
                  aliases: '-u',
                  default: false,
                  desc: 'Skip section uploader if true'
    class_option :'skip-migration',
                  type: :boolean,
                  aliases: '-m',
                  default: false,
                  desc: 'Skip initial migrations if true'
    class_option :'skip-setup',
                  type: :boolean,
                  aliases: '-p',
                  default: false,
                  desc: 'Skip setup if true'
    class_option :'skip-mount-engine',
                  type: :boolean,
                  aliases: '-engine',
                  default: false,
                  desc: 'Inject engine into routes'

    def create_initializer
      if !options[:'skip-setup']
        copy_file 'adminpanel_setup.rb', 'config/initializers/adminpanel_setup.rb'
      end
    end

    def create_section_uploader
      if !options[:'skip-section-uploader']
        copy_file 'section_uploader.rb', 'app/uploaders/adminpanel/section_uploader.rb'
      end
    end

    def inject_engine_into_routes
      if !options[:'skip-mount-engine']
        inject_into_file 'config/routes.rb', after: 'Rails.application.routes.draw do' do
          indent "\n  mount Adminpanel::Engine => '/panel'"
        end
      end
    end

    def create_adminpanel_migration
      if !options[:'skip-migration']
        migration_template 'create_adminpanel_tables.rb', 'db/migrate/create_adminpanel_tables.rb'
      end
    end

  end
end
