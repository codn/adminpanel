module Adminpanel
  class Galleryfile < ActiveRecord::Base
    include Adminpanel::Base
    include Adminpanel::SortableGallery

    belongs_to :gallery

    mount_uploader :file, Adminpanel::PhotoUploader

    def self.relation_field
      'gallery_id'
    end

    def self.display_name
      'dsf'
    end

  end
end
