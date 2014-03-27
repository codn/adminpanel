require 'rails/generators/active_record'
module Adminpanel
	module Generators
		class InitializeGenerator < ActiveRecord::Generators::Base
			desc "Generate the migrations necessary to start the gem"
  		source_root File.expand_path("../templates", __FILE__)
			argument :name, :type => :string, :default => "default", :require => false
			class_option :'skip-category',
				:type => :boolean,
				:aliases => '-c',
				:default => false,
				:desc => "Skip category skeleton and migration for it if true"
			class_option :'skip-section-uploader',
				:type => :boolean,
				:aliases => '-u',
				:default => false,
				:desc => 'Skip section uploader if true'
			class_option :'skip-migration',
				:type => :boolean,
				:aliases => '-m',
				:default => false,
				:desc => 'Skip initial migrations if true'
			class_option :'skip-setup',
				:type => :boolean,
				:aliases => '-p',
				:default => false,
				:desc => 'Skip setup if true'

			def create_initializers
				if !options[:'skip-setup']
					copy_file 'adminpanel_setup.rb', 'config/initializers/adminpanel_setup.rb'
				end
			end

			def create_categories
				if !options[:'skip-category']
					# puts "including category files"
					copy_file "category_template.rb", 'app/models/adminpanel/category.rb'
    			migration_template 'create_adminpanel_categories_table.rb', 'db/migrate/create_adminpanel_categories_table.rb'
				end
			end

			def create_section_uploader
				if !options[:'skip-section-uploader']
					copy_file "section_uploader.rb", 'app/uploaders/adminpanel/section_uploader.rb'
				end
			end

			def create_adminpanel_migration
				if !options[:'skip-migration']
    			migration_template 'create_adminpanel_tables.rb', 'db/migrate/create_adminpanel_tables.rb'
				end
			end

		end
	end
end
