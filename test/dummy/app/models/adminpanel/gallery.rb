module Adminpanel
  class Gallery < ActiveRecord::Base
    include Adminpanel::Base
    include Adminpanel::Sortable

    mount_uploader :file, Adminpanel::PhotoUploader

    mount_images :galleryfiles

    def name
      file
    end

    def self.form_fields
      [
        {
          'file' => {
            'type' => 'text',
            'label' => 'file',

          }
        },
        {
          'galleryfiles' => {
            'type' => 'adminpanel_file_fields',
            'label' => 'images for this gallery'
          }
        }
      ]
    end

    def self.display_name
      'Galeria'
    end

  end
end
