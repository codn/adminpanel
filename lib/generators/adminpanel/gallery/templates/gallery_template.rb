module Adminpanel
  class <%= class_name %> < Image
    # include Adminpanel::SortableGallery

    mount_uploader :file, <%= class_name %>Uploader
  end
end
