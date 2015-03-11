module Adminpanel
  class FileResourcefile < ActiveRecord::Base
    # include Adminpanel::SortableGallery

    mount_uploader :file, FileResourcefileUploader


    # def self.relation_field
    #   'file_test_id'
    # end

  end
end
