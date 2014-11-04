require 'rails/generators/active_record'
module Adminpanel
  class ContactGenerator < ActiveRecord::Generators::Base
    desc "Generate the migrations necessary to start the gem"
    source_root File.expand_path("../templates", __FILE__)
    argument :name, :type => :string, :default => "default", :require => false

    def copy_contact
      copy_file 'contact_template.rb', 'app/models/contact.rb'
    end
  end
end
