module Adminpanel
	class Image < ActiveRecord::Base
	  attr_accessible :file, :foreign_key, :model
	  mount_uploader :file, ImageUploader
	end
end