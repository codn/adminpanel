include Rails::Generators::Migration
module Adminpanel
	module Generators
		class InitializeGenerator < Rails::Generators::Base
			desc "Generate the migrations necessary to start the gem"
    		source_root File.expand_path("../templates", __FILE__)

    		def self.next_migration_number(path)
    			Time.now.utc.strftime("%Y%m%d%H%M%S")
    		end

			def create_migration
        		migration_template 'create_adminpanel_tables.rb', 'db/migrate/create_adminpanel_tables.rb'
			end
		end
	end
end