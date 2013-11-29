require "carrierwave"
require "carrierwave/orm/activerecord"
module Adminpanel
	class Gallery < ActiveRecord::Base
	  attr_accessible :file

	  mount_uploader :file, Adminpanel::GalleryUploader
	  validates_presence_of :file
	end
end