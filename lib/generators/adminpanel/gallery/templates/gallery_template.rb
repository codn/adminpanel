module Adminpanel
  class <%= class_name %> < ActiveRecord::Base
    # include Adminpanel::Base # required for galleryzation
    # include Adminpanel::Galleryzation

    # belongs_to :<%= reference_name %>

    mount_uploader :file, <%= class_name %>Uploader


    # def self.relation_field
    #   '<%= reference_name %>_id'
    # end

    # def self.display_name
    #   '<%= class_name %>'
    # end

  end
end
