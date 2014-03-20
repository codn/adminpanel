module Adminpanel
  class Photo < ActiveRecord::Base
    attr_accessible :product_id, :file

    mount_uploader :file, PhotoUploader
    
  end
end
