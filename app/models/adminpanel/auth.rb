module Adminpanel
  class Auth < ActiveRecord::Base
    include Adminpanel::Base
    include Adminpanel::Facebook

    def self.form_attributes
      [
        {
          'name' => {
            'type' => 'text_field',
          }
        },
        {
          'value' => {
            'type' => 'wysiwyg_field',
            'show' => 'show'
          }
        },
        {
          'key' => {
            'type' => 'text_field',
          }
        }
      ]
    end

    def self.display_name
      'Auth'
    end
  end
end
