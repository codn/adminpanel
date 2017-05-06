module Adminpanel
  class RandomPagefile < Image
    # include Adminpanel::SortableGallery

    mount_uploader :file, RandomPagefileUploader

    # Warning: This method prevents the file from recreating versions,
    # use it at your own risk delete the original file
    # def remove_original attachment
    #   File.delete "#{Rails.root.join('public')}#{file_url}" if file
    # end
  end
end
