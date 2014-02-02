require "action_view"
include Rails::Generators::Migration
module Adminpanel
	module Generators
		class ResourceGenerator < Rails::Generators::Base

    		source_root File.expand_path("../templates", __FILE__)
    		argument :resource_name, :type => :string
    		argument :fields, :type => :hash, :default => "name:string"
			desc "Generate the resource files necessary to use a model"

			def self.next_migration_number(path)
	 			Time.now.utc.strftime("%Y%m%d%H%M%S")
			end

			def create_model
        		template 'resource.rb', "app/models/adminpanel/#{lower_name}.rb"
			end

			def create_controller
				template "controller.rb", "app/controllers/adminpanel/#{pluralized_name}_controller.rb"
			end

			def create_migrations
				migration_template "migration.rb", "db/migrate/create_#{pluralized_name}_table"
				# generate "migration.rb", "db/migrate/create_#{pluralized_name}_table"
			end


			private

			def lower_name
				resource_name.singularize.downcase
			end

			def capitalized_resource
				lower_name.capitalize
			end

			def pluralized_name
				"#{lower_name.pluralize}"
			end

			def symbolized_attributes
		        attributes = ""
		        fields.each do |field, type|
		        	if type == "images"
		            	attributes = attributes + ":images_attributes, "
		        	else
		            	attributes = attributes + ":#{field}, "
		        	end
		        end
		        2.times do
		        	attributes.chop! #to remove the last white space and the last ","
		        end
		        attributes
			end

			def adminpanel_form_attributes
				form_hash = ""
				fields.each do |field, type|
					if type == "string" || type == "float"
						form_hash = form_hash + "\n\t\t\t\t{\"#{field}\" => {\"type\" => \"text_field\", \"name\" => \"#{field}\", \"label\" => \"#{field}\", \"placeholder\" => \"#{field}\"}},"
					elsif type == "text" || type == "wysiwyg"
						form_hash = form_hash + "\n\t\t\t\t{\"#{field}\" => {\"type\" => \"wysiwyg_field\", \"name\" => \"#{field}\", \"label\" => \"#{field}\", \"placeholder\" => \"#{field}\"}},"
					elsif type == "integer"
						form_hash = form_hash + "\n\t\t\t\t{\"#{field}\" => {\"type\" => \"number_field\", \"name\" => \"#{field}\", \"label\" => \"#{field}\", \"placeholder\" => \"#{field}\"}},"
					elsif type == "datepicker"
						form_hash = form_hash + "\n\t\t\t\t{\"#{field}\" => {\"type\" => \"datepicker\", \"name\" => \"#{field}\", \"label\" => \"#{field}\", \"placeholder\" => \"#{field}\"}},"
					elsif type == "images"
						form_hash = form_hash + "\n\t\t\t\t{\"#{field}\" => {\"type\" => \"adminpanel_file_field\", \"name\" => \"#{field}\"}},"
					end
				end
				form_hash
			end

			def migration_string(field, type)
				if type == "datepicker"
					"t.string :#{field}"
				elsif type == "images"
					""
				elsif type == "wysiwyg"
					"t.text :#{field}"
				else
					"t.#{type} :#{field}"
				end
			end

			def has_images?
				fields.each do |field, type|
					if type == "images"
						return true
					end
				end
				return false
			end

			def image_relationship
				return "has_many :images, :foreign_key => \"foreign_key\", :conditions => { :model => \"#{lower_name}\" }
		accepts_nested_attributes_for :images, :allow_destroy => true
		#remember to change the relationship if you change this model display_name"
			end
		end
	end
end