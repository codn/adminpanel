module Adminpanel
  class Gallery < ActiveRecord::Base
    include Adminpanel::Base
    include Adminpanel::Sortable

    mount_images :galleryfiles

    mount_uploader :file, Adminpanel::PhotoUploader

    def name
      self['file']
    end

    def self.form_attributes
      [
        {
          'file' => {
            'type' => 'file_field',
            'label' => 'file',

          }
        },
        {
          'galleryfiles' => {
            'type' => 'adminpanel_file_field',
            'label' => 'galleryfiels'
          }
        }
      ]
    end

    def self.display_name
      'Galeria'
    end

  end
end
