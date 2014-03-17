require "carrierwave"
require "carrierwave/orm/activerecord"
module Adminpanel
	class Gallery < ActiveRecord::Base
	  attr_accessible :file

	  mount_uploader :file, Adminpanel::GalleryUploader
	  validates_presence_of :file
	  before_create :set_position
	  before_destroy :rearrange_positions


	  default_scope { order("position ASC")}


	  def move_to_better_position
	  	if position > 1
		  	conflicting_gallery = Gallery.find_by_position(position - 1)
		  	update_attribute(:position, position - 1)
		  	conflicting_gallery.update_attribute(
		  		:position, conflicting_gallery.position + 1
		  		)
		  	true
	  	else
	  		false
	  	end
	  end

	  def move_to_worst_position
	  	records = Gallery.count
	  	if position < records
		  	conflicting_gallery = Gallery.find_by_position(position + 1)
		  	update_attribute(:position, position + 1)
		  	conflicting_gallery.update_attribute(
		  		:position, conflicting_gallery.position - 1
		  		)
		  	true
	  	else
	  		false
	  	end
	  end

		def self.display_name
			"Galería"
		end

  	private
  		def rearrange_positions
  			unarranged_galleries = Gallery.where("position > ?", position)
  			unarranged_galleries.each do |gallery|
  				gallery.update_attribute(:position, gallery.position - 1)
  			end

  		end

		def set_position
		  	last_record = Gallery.last
		  	if last_record.nil?
		  		self.position = 1
		  	else
		  		self.position = last_record.position + 1
		  	end
		end
	end
end
