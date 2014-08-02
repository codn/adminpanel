module Adminpanel
  module ResourceGeneratorHelper
    def setup_is_found?
      if Dir.exists?('config') && Dir.exists?('config/initializers') && File.exists?('config/initializers/adminpanel_setup.rb')
        true
      else
        false
      end
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

    def assign_attributes_variables(attribute)
      @attr_field = attribute.split(":").first
      if attribute.split(":").second.nil?
        @attr_type = "string"
      else
        @attr_type = attribute.split(":").second
      end
    end

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
      !options[:'skip-gallery']
    end

    def resource_name
      name.singularize.downcase #normalize name to downcase and singular
    end

    def gallery_name
      "#{resource_name}file" #ex: postfile
    end

    def camelized_resource
      resource_name.camelize
    end

    def pluralized_name
      "#{resource_name.pluralize}"
    end

    def symbolized_attributes
      fields.map do |attribute|
        assign_attributes_variables(attribute)
        case @attr_type
          when 'belongs_to'
            ':' + belongs_to_field(@attr_field)
          when 'has_many'
            has_many_field(@attr_field) + ': []'
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
      attribute_hash(@attr_field, 'text_field')
    end

    def float_form_hash
      attribute_hash(@attr_field, 'text_field')
    end

    def text_form_hash
      attribute_hash(@attr_field ,'wysiwyg_field')
    end

    def integer_form_hash
      attribute_hash(@attr_field, 'number_field')
    end

    def boolean_form_hash
      attribute_hash(@attr_field, 'boolean')
    end

    def datepicker_form_hash
      attribute_hash(@attr_field, 'datepicker')
    end

    def file_field_form_hash
      attribute_hash(gallery_name.pluralize, 'adminpanel_file_field')
    end

    def belongs_to_form_hash
      attribute_hash(belongs_to_field(@attr_field), 'belongs_to', resource_class_name(@attr_field))
    end

    def has_many_form_hash
      attribute_hash(has_many_field(resource_class_name(@attr_field)), 'has_many', 'has_many model')
    end

    def attribute_hash(name, type, model = '')
      if model != ''
        model = model_type(model) + ",\n"
      end
      "{\n" +
        indent("'#{name}'" + " => {\n", 2) +
          indent(form_type(type), 4) + ",\n" +
          indent(label_type, 4) + ",\n" +
          indent(placeholder_type, 4) + ",\n" +
          indent(model, 4) +
        indent("}\n", 2) +
      '}'
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
      return "# has_many :categorizations\n\t\t" +
      "# has_many :#{@attr_field}, " +
      ":through => :categorizations, " +
      ":dependent => :destroy\n\t\t"
    end

    def get_gallery
      return "\n\t\tmount_images :#{gallery_name.pluralize}\n"
    end

  end
end
