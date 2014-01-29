module ActiveRecordExtension
  extend ActiveSupport::Concern
  #instance methods
  # def foo
    
  # end

  # static(class) methods
  module ClassMethods
    def form_attributes
      {
        :name => {:type => "text_field", :name => ":name"}
      }
    end

    def display_name
      "display_name"
    end

    def has_images?
      form_attributes.each do |attribute, values|
        if values[:type] == "adminpanel_file_field"
          return true
        end
      end
      false
    end
  end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtension)