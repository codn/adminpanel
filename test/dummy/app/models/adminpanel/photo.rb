module Adminpanel
  class Photo < ActiveRecord::Base
    include Adminpanel::Base
    # include Adminpanel::Galleryzation
    mount_uploader :file, PhotoUploader

  end
end
