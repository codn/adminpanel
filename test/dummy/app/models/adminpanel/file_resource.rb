module Adminpanel
  class FileResource < ActiveRecord::Base
    include Adminpanel::Base

		mount_images :file_resourcefiles

    def self.form_attributes
      [
        {
          'name' => {
            'type' => 'text_field',
            'label' => 'name',
            'placeholder' => 'name',
          }
        },
        {
          'file_resourcefiles' => {
            'type' => 'adminpanel_file_field',
            'label' => 'name',
            'placeholder' => 'name'
          }
        }
      ]
    end

    def self.display_name
      'FileResource' #singular
    end

    # def self.icon
    #   "truck" # fa-{icon}
    # end
  end
end
