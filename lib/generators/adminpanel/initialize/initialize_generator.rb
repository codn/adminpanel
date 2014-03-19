# include Rails::Generators::Migration
require 'rails/generators/active_record'
module Adminpanel
	module Generators
		class InitializeGenerator < ActiveRecord::Generators::Base
			desc "Generate the migrations necessary to start the gem"
  		source_root File.expand_path("../templates", __FILE__)
			argument :name, :type => :string, :default => "Admi", :require => false
			class_option :include_category, :type => :boolean, :aliases => "-c", :default => true, :desc => "Include category skeleton and migration for it"

  		# def self.next_migration_number(path)
  		# 	Time.now.utc.strftime("%Y%m%d%H%M%S")
  		# end

			def create_initializers
				copy_file 'adminpanel_setup.rb', 'config/initializers/adminpanel_setup.rb'
			end

			def create_categories
				if options[:include_category]
					puts "including category files"
					copy_file "category_template.rb", 'app/models/adminpanel/category.rb'
    			migration_template 'create_adminpanel_categories_table.rb', 'db/migrate/create_adminpanel_categories_table.rb'
				end
			end

			def create_migration
    		migration_template 'create_adminpanel_tables.rb', 'db/migrate/create_adminpanel_tables.rb'
			end

		end
	end
end
