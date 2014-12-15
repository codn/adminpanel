module Adminpanel
  class Gallery < ActiveRecord::Base
    include Adminpanel::Base
    include Adminpanel::Sortable

    mount_uploader :file, Adminpanel::PhotoUploader

    def name
      file
    end

    def self.form_fields
      [
        {
          'file' => {
            'type' => 'adminpanel_file_field',
            'label' => 'file',

          }
        }
      ]
    end

    def self.display_name
      'Galeria'
    end

    def self.gallery_children
      'galleryfiles'
    end
  end
end
