module Adminpanel
  class Galleryfile < Image
    include Adminpanel::SortableGallery

    mount_uploader :file, Adminpanel::PhotoUploader

    belongs_to :gallery

    def self.relation_field
      'gallery_id'
    end

    def self.dispaly_name
      'ja'
    end
  end
end
