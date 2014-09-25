require "carrierwave"
require "carrierwave/orm/activerecord"
module Adminpanel
  class Gallery < ActiveRecord::Base
    include Adminpanel::Base
    include Adminpanel::Galleryzation

    mount_uploader :file, Adminpanel::GalleryUploader

    validates_presence_of :file

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
        {
          'file' => {
            'type' => 'file_field',
            'label' => I18n.t('model.attributes.file'),
          }
        }
      ]
    end

    def self.display_name
      I18n.t('model.Gallery')
    end

    def self.icon
      'picture-o'
    end

    def name
      File.basename(file.path)
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
