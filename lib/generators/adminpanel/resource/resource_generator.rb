require "action_view"
include Rails::Generators::Migration
module Adminpanel
	module Generators
		class ResourceGenerator < Rails::Generators::Base

  		source_root File.expand_path("../templates", __FILE__)
  		argument :resource_name, :type => :string
  		argument :fields, :type => :array, :default => "name:string"
			desc "Generate the resource files necessary to use a model"

			def self.next_migration_number(path)
	  		Time.now.utc.strftime("%Y%m%d%H%M%S")
			end

			def create_model
    		template 'resource.rb', "app/models/adminpanel/#{lower_name}.rb"
			end

			def create_controller
				if is_a_resource?
					template "controller.rb", "app/controllers/adminpanel/#{pluralized_name}_controller.rb"
				end
			end

			def create_migrations
				migration_template "migration.rb", "db/migrate/create_#{pluralized_name}_table"
			end


		private
			def is_a_resource?
				fields.each do |attribute|
					assign_attributes_variables(attribute)
					if @attr_type != "belongs_to"
						return true
					end
				end
				false
			end

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

			def has_many_field(resource)
				"#{resource.singularize.downcase}_ids"
			end

			def resource_class_name(resource)
				"#{resource.singularize.capitalize}"
			end

			def models_in_parameter(field)
				models = []
				field.split(",").each do |member|
					models << member.downcase.pluralize
				end
				models
			end

			def assign_attributes_variables(attribute)
				if attribute.split(":").second.nil?
					@attr_field = attribute
					@attr_type = "string"
				else
					@attr_field = attribute.split(":").first
					@attr_type = attribute.split(":").second
				end
			end

			def symbolized_attributes
        attr_string = ""
        fields.each do |attribute|

					assign_attributes_variables(attribute)

        	if @attr_type == "images"
            	attr_string = attr_string + ":images_attributes, "
        	elsif @attr_type == "belongs_to"
        		attr_string = "#{attr_string}:#{belongs_to_field(@attr_field)}, "
        	elsif @attr_type == "has_many" || @attr_type == "has_many_through"
        		if @attr_field.split(",").second == nil
        			attr_string = "#{attr_string}:#{has_many_field(@attr_field)}, "
        		else
        			model_name = models_in_parameter(@attr_field).first
        			attr_string = "#{attr_string}:#{has_many_field(model_name)}, "
        		end
        	else
            	attr_string = attr_string + ":#{@attr_field}, "
        	end
        end
        2.times do
        	attr_string.chop! #to remove the last white space and the last ","
        end
        attr_string
			end

			def adminpanel_form_attributes
				form_hash = ""
				fields.each do |attribute|

					assign_attributes_variables(attribute)

					if @attr_type == "string" || @attr_type == "float"
						form_hash = form_hash + "\n\t\t\t\t{\"#{@attr_field}\" => {\"type\" => \"text_field\", \"name\" => \"#{@attr_field}\", \"label\" => \"#{@attr_field}\", \"placeholder\" => \"#{@attr_field}\"}},"
					elsif @attr_type == "text" || @attr_type == "wysiwyg"
						form_hash = form_hash + "\n\t\t\t\t{\"#{@attr_field}\" => {\"type\" => \"wysiwyg_field\", \"name\" => \"#{@attr_field}\", \"label\" => \"#{@attr_field}\", \"placeholder\" => \"#{@attr_field}\"}},"
					elsif @attr_type == "integer"
						form_hash = form_hash + "\n\t\t\t\t{\"#{@attr_field}\" => {\"type\" => \"number_field\", \"name\" => \"#{@attr_field}\", \"label\" => \"#{@attr_field}\", \"placeholder\" => \"#{@attr_field}\"}},"
					elsif @attr_type == "datepicker"
						form_hash = form_hash + "\n\t\t\t\t{\"#{@attr_field}\" => {\"type\" => \"datepicker\", \"name\" => \"#{@attr_field}\", \"label\" => \"#{@attr_field}\", \"placeholder\" => \"#{@attr_field}\"}},"
					elsif @attr_type == "images"
						form_hash = form_hash + "\n\t\t\t\t{\"#{@attr_field}\" => {\"type\" => \"adminpanel_file_field\", \"name\" => \"#{@attr_field}\"}},"
					elsif @attr_type == "belongs_to"
						form_hash = form_hash + "\n\t\t\t\t{\"#{belongs_to_field(@attr_field)}\" => {\"@attr_type\" => \"belongs_to\", \"model\" => \"Adminpanel\:\:#{resource_class_name(@attr_field)}\", \"name\" => \"#{belongs_to_field(@attr_field)}\"}},"
					elsif @attr_type == "has_many" || @attr_type == "has_many_through"
						if models_in_parameter(@attr_field).second.nil?
							through_model = @attr_field
						else
							through_model = models_in_parameter(@attr_field).first
						end
						through_model = resource_class_name(through_model)
						form_hash = form_hash + "\n\t\t\t\t{\"#{has_many_field(through_model)}\" => {\"type\" => \"has_many\", \"model\" => \"Adminpanel\:\:#{through_model}\", \"name\" => \"#{has_many_field(through_model)}\"}},"
					end
				end
				form_hash
			end

			def migration_string(field, type)
				if type == "datepicker"
					"t.string :#{field}"
				elsif type == "wysiwyg"
					"t.text :#{field}"
				elsif type == "belongs_to"
					"t.integer :#{belongs_to_field(field)}"
				elsif type == "images" || type == "has_many" || type == "has_many_through"
					""# no need for an association here.
				else
					"t.#{type} :#{field}"
				end
			end

			def has_associations?
				fields.each do |attribute|
					assign_attributes_variables(attribute)
					if @attr_type == "images" || @attr_type == "belongs_to" || @attr_type == "has_many" || @attr_type == "has_many_through"
						return true
					end
				end
				return false
			end

			def associations
				association = ""
				fields.each do |attribute|
					assign_attributes_variables(attribute)
					if @attr_type == "belongs_to"
						association = "#{association}#{belongs_to_association(@attr_field)}"
					elsif @attr_type == "images"
						association = "#{association}#{image_association}"
					elsif @attr_type == "has_many" || @attr_type == "has_many_through"
						association = "#{association}#{has_many_association(@attr_field)}"
					end

				end
				association
			end

			def belongs_to_association(field)
				"belongs_to :#{field.singularize.downcase}\n\t\t"
			end

			def has_many_association(field)
				if models_in_parameter(field).second.nil?
					return "has_many :#{models_in_parameter(field).first}\n\t\t" +
					"has_many :#{models_in_parameter(field).first}, " +
					":through => :#{models_in_parameter(field).first}ation, " +
					":dependent => :destroy\n\t\t"
				else
					return "has_many :#{models_in_parameter(field).second}\n\t\t" +
					"has_many :#{models_in_parameter(field).first}, " +
					":through => :#{models_in_parameter(field).second}, " +
					":dependent => :destroy\n\t\t"
				end
			end

			def image_association
				return "has_many :images, :foreign_key => \"foreign_key\", " +
				":conditions => { :model => \"#{lower_name}\" } \n\t\t" +
				"accepts_nested_attributes_for :images, :allow_destroy => true\n\t\t" +
				"#remember to change the association if you change this model display_name\n\t\t"
			end
		end
	end
end
