module Adminpanel
	class Image < ActiveRecord::Base

		attr_accessible :file

		validates_presence_of :file

		mount_uploader :file, Adminpanel::SectionUploader
	end
end
