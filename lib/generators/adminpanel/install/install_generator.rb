require "rails/generators/active_record"
module Adminpanel
	module Generators
		class InstallGenerator < ActiveRecord::Generators::Base
    		source_root File.expand_path("../templates", __FILE__)
    		
			def create_migrations
        		migration_template 'migrations/create_adminpanel_tables.rb', 'db/migrate/create_adminpanel_tables.rb'
			end
		end
	end
end