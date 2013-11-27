module Adminpanel
	class Gallery < ActiveRecord::Base
	  attr_accessible :description, :file, :name

	  mount_uploader :file, GalleryUploader
	  validates_presence_of :description
	  validates_presence_of :file
	  validates_presence_of :name
	end
end