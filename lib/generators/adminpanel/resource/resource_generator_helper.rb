module Adminpanel
  module ResourceGeneratorHelper
    def needs_name?
      fields.each do |attribute|
        return false if attribute.split(':').first == 'name'
      end
      true
    end

    def class_name
      "#{resource_name}_#{@attr_field}".camelize
    end

    def select_field(resource)
      "#{resource.singularize.downcase}_id"
    end

    def checkbox_field(resource)
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
        if @attr_type != 'select'
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
        when 'select'
          ":#{select_field(@attr_field)}"
        when 'checkbox'
          "{ #{checkbox_field(@attr_field)}: [] }"
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

    def file_form_hash
      attribute_hash(@attr_field, 'file_field')
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

    def select_form_hash
      attribute_hash(select_field(@attr_field), 'select', resource_class_name(@attr_field))
    end

    def checkbox_form_hash
      attribute_hash(checkbox_field(resource_class_name(@attr_field.downcase.singularize + 's')), 'checkbox', @attr_field.capitalize.singularize)
    end

    def attribute_hash(name, type, model = '')
      model = model_type(model) + ",\n" if model != ''
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

    def model_type(model_name)
      "'options' => Proc.new { |object|\n" +
        indent("Adminpanel::#{model_name}.all\n", 2) +
      '}'
    end

    def has_associations?
      fields.each do |attribute|
        assign_attributes_variables(attribute)
        if( @attr_type == 'images' ||
            @attr_type == 'select' ||
            @attr_type == 'checkbox' ||
            @attr_type == 'file' ||
            has_gallery? )
          return true
        end
      end
      return false
    end

    def associations
      association = ""
      fields.each do |attribute|
        assign_attributes_variables(attribute)
        case @attr_type
        when 'select'
          association = "#{association}#{select_association(@attr_field)}"
        when 'checkbox'
          association = "#{association}#{checkbox_association(@attr_field)}"
        when 'file'
          association = "#{association}#{file_assocation(@attr_field)}"
        end
      end

      if has_gallery?
        association = "#{association}mount_images :#{gallery_name.pluralize}\n\t\t"
      end

      association
    end

    def select_association(field)
      "belongs_to :#{field.singularize.downcase}\n\t\t"
    end

    def checkbox_association(field)
      return "# has_many :#{@attr_field.downcase}zations\n\t\t" +
      "# has_many :#{@attr_field.pluralize.downcase}, " +
      "through: :#{@attr_field.downcase}zations, " +
      "dependent: :destroy\n\t\t"
    end

    def file_assocation(field)
      "mount_uploader :#{field}, #{class_name}Uploader\n\t\t"
    end

  end
end
