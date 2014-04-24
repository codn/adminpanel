module Adminpanel
  class <%= class_name %> < ActiveRecord::Base

    mount_uploader :file, <%= class_name %>Uploader

    # act_as_a_gallery

    # def self.relation_field
    #   'something_id'
    # end

  end
end
