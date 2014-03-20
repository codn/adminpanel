module Adminpanel
  class <%= class_name %> < ActiveRecord::Base
    attr_accessible :<%= reference_name %>_id, :file

    mount_uploader :file, <%= class_name %>Uploader

  end
end
