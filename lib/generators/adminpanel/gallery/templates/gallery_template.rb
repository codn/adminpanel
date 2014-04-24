module Adminpanel
  class <%= class_name %> < ActiveRecord::Base
    # include Adminpanel::Galleryzation

    mount_uploader :file, <%= class_name %>Uploader


    # def self.relation_field
    #   '<%= reference_name %>_id'
    # end

  end
end
