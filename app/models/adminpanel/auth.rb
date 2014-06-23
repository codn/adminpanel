module Adminpanel
  class Auth < ActiveRecord::Base
    include Adminpanel::Base

    def self.form_attributes
      [
        {
          'name' => {
            'type' => 'text_field',
            'label' => 'Cuenta:'
          }
        },
        {
          'value' => {
            'type' => 'wysiwyg_field',
            'show' => 'show',
            'label' => 'Access Key'
          }
        },
        {
          'key' => {
            'type' => 'text_field',
            'label' => 'Llave'
          }
        }
      ]
    end

    def self.routes_options
      { except: [:edit, :update ], path: display_name.pluralize(I18n.default_locale).downcase }
    end

    def self.icon
      'cubes'
    end

    def self.display_name
      'Cuenta'
    end
  end
end
