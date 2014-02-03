module ActiveRecordExtension
  extend ActiveSupport::Concern
  #instance methods
  # def foo
    
  # end

  # static(class) methods
  module ClassMethods
    def form_attributes
      [{
        "name" => {"type" => "text_field", "name" => ":name"}
      }]
    end

    def display_name
      "display_name"
    end

    def has_images?
      form_attributes.each do |fields|
      fields.each do |attribute, properties|
        if properties["type"] == "adminpanel_file_field"
          return true
        end
      end
      end
      return false
    end

    def icon
      "icon-truck"
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)