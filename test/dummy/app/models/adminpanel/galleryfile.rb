module Adminpanel
  class Galleryfile < Image
    include Adminpanel::SortableGallery

    mount_uploader :file, Adminpanel::PhotoUploader
  end
end
