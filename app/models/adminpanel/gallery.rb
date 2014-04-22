require "carrierwave"
require "carrierwave/orm/activerecord"
module Adminpanel
	class Gallery < ActiveRecord::Base

	  mount_uploader :file, Adminpanel::GalleryUploader
	  validates_presence_of :file

		act_as_a_gallery

		def move_to_better_position
			if self.position > 1
				conflicting_gallery = Gallery.find_by_position(position - 1)
				self.update_attribute(:position, self.position - 1)
				conflicting_gallery.update_attribute(
					:position, conflicting_gallery.position + 1
					)
				true
			else
				false
			end
		end

		def move_to_worst_position
			records = self.class.count
			if self.position < records
				conflicting_gallery = Gallery.find_by_position(position + 1)
				update_attribute(:position, self.position + 1)
				conflicting_gallery.update_attribute(
					:position, conflicting_gallery.position - 1
					)
				true
			else
				false
			end
		end


		def self.form_attributes
			[
				{'file' => {
					'type' => 'file_field',
					'name' => 'Archivo' }
				}
			]
		end

		def self.display_name
			"Galería"
		end

		def self.icon
			'icon-picture'
		end

	private
		def rearrange_positions
			unarranged_galleries = Gallery.where("position > ?", self.position)
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
