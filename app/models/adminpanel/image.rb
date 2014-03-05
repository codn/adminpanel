module Adminpanel
	class Image < ActiveRecord::Base
		extend ImagesHelper

		attr_accessible :file, :foreign_key, :model
		validates_presence_of :model
		validates_presence_of :file

		if is_class?("CustomImageUploader")
	  		mount_uploader :file, CustomImageUploader
		else
	  		mount_uploader :file, Adminpanel::ImageUploader
		end
	end
end
