module Adminpanel
  class <%= class_name %> < Image
    # include Adminpanel::SortableGallery

    mount_uploader :file, <%= class_name %>Uploader
    
    
    # Warning: This method prevents the file from recreating versions,
    # use it at your own risk delete the original file
    # def remove_original attachment
    #   File.delete "#{Rails.root.join('public')}#{file_url}" if file
    # end
  end
end
