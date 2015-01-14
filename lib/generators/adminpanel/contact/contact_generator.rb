require 'rails/generators/active_record'
module Adminpanel
  class ContactGenerator < ActiveRecord::Generators::Base
    desc 'Generate the contact template to use with a mail form'
    source_root File.expand_path('../templates', __FILE__)
    argument :name, type: :string, default: '', required: false
    argument :fields, type: :array, default: [], required: false

    def copy_contact
      fields = extract_fields
      template 'contact_template.rb', 'app/models/contact.rb'
    end

    private
      def extract_fields
        if fields.empty? && name == ''
          fields << 'email' << 'body'
        elsif name != ''
          fields << name
        end
        return fields
      end
  end
end
