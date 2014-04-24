module Adminpanel
  class Photo < ActiveRecord::Base

    mount_uploader :file, PhotoUploader

  end
end
