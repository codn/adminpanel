require "action_view"
include Rails::Generators::Migration
module Adminpanel
	module Generators
		class ResourceGenerator < Rails::Generators::Base

    		source_root File.expand_path("../templates", __FILE__)
    		argument :resource_name, :type => :string, :default => "Resource"
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

			def belongs_to_field(resource)
				"#{resource.singularize.downcase}_id"
			end

			def resource_class_name(resource)
				"#{resource.singularize.capitalize}"
			end

			def symbolized_attributes
		        attributes = ""
		        fields.each do |field, type|
		        	if type == "images"
		            	attributes = attributes + ":images_attributes, "
		        	elsif type == "belongs_to"
		        		attributes = "#{attributes}:#{belongs_to_field(field)}, "
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
					elsif type == "belongs_to"
						form_hash = form_hash + "\n\t\t\t\t{\"#{belongs_to_field(field)}\" => {\"type\" => \"belongs_to\", \"model\" => \"Adminpanel\:\:#{resource_class_name(field)}\", \"name\" => \"#{belongs_to_field(field)}\"}},"
					end
				end
				form_hash
			end

			def migration_string(field, type)
				if type == "datepicker"
					"t.string :#{field}"
				elsif type == "images"
					""# no need for a association here.
				elsif type == "wysiwyg"
					"t.text :#{field}"
				elsif type == "belongs_to"
					"t.integer :#{belongs_to_field(field)}"
				else
					"t.#{type} :#{field}"
				end
			end

			def has_associations?
				fields.each do |field, type|
					if type == "images" || type == "belongs_to"
						return true
					end
				end
				return false
			end

			def associations
				association = ""
				fields.each do |field, type|
					if type == "belongs_to"
						association = "#{association}#{belongs_to_association(field)}"
					elsif type == "images"
						association = "#{association}#{image_association}"
					end
						
				end
				association
			end

			def belongs_to_association(field)
				"belongs_to :#{field.singularize.downcase}\n\t\t"
			end

			def image_association
				return "has_many :images, :foreign_key => \"foreign_key\", :conditions => { :model => \"#{lower_name}\" }
		accepts_nested_attributes_for :images, :allow_destroy => true
		#remember to change the association if you change this model display_name\n\t\t"
			end
		end
	end
end