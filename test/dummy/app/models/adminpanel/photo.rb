module Adminpanel
  class Photo < Image
    # include Adminpanel::SortableGallery
    mount_uploader :file, PhotoUploader
  end
end
