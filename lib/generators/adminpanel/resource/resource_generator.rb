# require "action_view"
require 'rails/generators/active_record'
module Adminpanel
	module Generators
		class ResourceGenerator < ActiveRecord::Generators::Base
  		source_root File.expand_path("../templates", __FILE__)
			desc "Generate the resource files necessary to use a model"
			class_option :'include-gallery',
				:type => :boolean,
				:aliases => '-g',
				:default => true,
				:desc => 'Creates the gallery for this resource'

  		argument :fields, :type => :array, :default => [], :banner => "field[:type][:index] field[:type][:index]"

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
    		template 'resource.rb', "app/models/adminpanel/#{lower_singularized_name}.rb"
			end

			def generate_controller
				if is_a_resource?
					template "controller.rb", "app/controllers/adminpanel/#{pluralized_name}_controller.rb"
				end
			end

			def generate_migrations
				invoke :migration, ["create_adminpanel_#{pluralized_name}", fields]
			end

			def print_messages
				puts "don't forget to add :#{pluralized_name} to adminpanel_setup.rb"
			end

		private

			def is_a_resource?
				fields.each do |attribute|
					assign_attributes_variables(attribute)
					if @attr_type != 'belongs_to'
						return true
					end
				end
				false
			end

			def has_gallery?
				options[:'include-gallery']
			end

			def gallery_name
				"#{lower_singularized_name}file"
			end

			def lower_singularized_name
				name.singularize.downcase
			end

			def capitalized_resource
				lower_singularized_name.capitalize
			end

			def pluralized_name
				"#{lower_singularized_name.pluralize}"
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
				fields.map do |attribute|
					assign_attributes_variables(attribute)
					case @attr_type
						when 'belongs_to'
	        		':' + belongs_to_field(@attr_field)
						when 'has_many'
							':' + has_many_field(@attr_field)
						else
						":#{attribute.split(':').first}"
					end
				end.join(",\n")
			end

			def get_attribute_hash
				fields.map do |attribute|
					assign_attributes_variables(attribute)
					send(@attr_type + '_form_hash')
				end.join(", \n")
			end

			def string_form_hash
				attribute_hash('text_field')
			end

			def float_form_hash
				attribute_hash('text_field')
			end

			def text_form_hash
				attribute_hash('wysiwyg_field')
			end

			def integer_form_hash
				attribute_hash('number_field')
			end

			def boolean_form_hash
				attribute_hash('boolean')
			end

			def datepicker_form_hash
				attribute_hash('datepicker')
			end

			def file_field_form_hash
				file_field_hash
			end

			def belongs_to_form_hash
				belongs_to_attribute_hash(belongs_to_field(@attr_field))
			end

			def has_many_form_hash
				has_many_attribute_hash(has_many_field(resource_class_name(@attr_field)), 'through_model')
			end

			def attribute_hash(type)
				"{\n" +
					indent("'#{@attr_field}'" + " => {\n", 2) +
						"#{indent(form_type(type), 4)},\n" +
						"#{indent(label_type, 4)},\n" +
						"#{indent(placeholder_type, 4)}\n" +
					indent("}\n", 2) +
				'}'

			end

			def file_field_hash
				"{\n" +
					indent("'#{gallery_name.pluralize}'", 2) + "=> {\n" +
						"#{indent(form_type('adminpanel_file_field'), 4)},\n" +
						"#{indent(label_type, 4)},\n" +
						"#{indent(placeholder_type, 4)}\n" +
					indent("}\n", 2) +
				'}'
			end

			def belongs_to_attribute_hash(name)
				"{\n" +
				 	indent("'#{name}'", 2) + "=> {\n" +
						indent(model_type(resource_class_name(@attr_field)), 4) + ",\n" +
						indent(label_type, 4) + "\n" +
						indent(placeholder_type, 4) + "\n" +
					indent("}\n", 2) +
				"}"
			end

			def has_many_attribute_hash(name, through_model)
				"{\n" +
				 	indent("'#{name}'", 2) + "=> {\n" +
						indent(model_type(through_model), 4) + ",\n" +
						indent(label_type, 4) + "\n" +
						indent(placeholder_type, 4) + "\n" +
					indent("}\n", 2) +
				"}"
			end

			def starting_hash(name)
				"\n{\n'#{name}'"
			end

			def form_type(type)
				"'type' => '#{type}'"
			end

			def label_type
				"'label' => '#{@attr_field}'"
			end

			def placeholder_type
				"'placeholder' => '#{@attr_field}'"
			end

			def model_type(type)
				"'model' => 'Adminpanel::#{type}'"
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
					has_many_name = models_in_parameter(field).first
				else
					has_many_name = models_in_parameter(field).second
				end
				return "# has_many :categorizations\n\t\t" +
				"# has_many :#{@attr_field}, " +
				":through => :categorizations, " +
				":dependent => :destroy\n\t\t"
			end

			def image_association
				generate_gallery
				return "\n\t\tmount_images :#{gallery_name.pluralize}\n"
			end

			def generate_gallery
				invoke 'adminpanel:gallery', [lower_singularized_name]
			end

		end
	end
end
