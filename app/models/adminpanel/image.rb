module Adminpanel
	class Image < ActiveRecord::Base
		extend ClassDefinitionsHelper

		attr_accessible :file
		validates_presence_of :file

		if is_class?("SectionUploader")
	  		mount_uploader :file, SectionUploader
		else
	  		mount_uploader :file, Adminpanel::ImageUploader
		end
	end
end
