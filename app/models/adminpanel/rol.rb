module Adminpanel
  class Rol < ActiveRecord::Base
    include Adminpanel::Base
    has_many :permissions
    validates_presence_of :name
    validates_uniqueness_of :name

    def self.form_attributes
      [
        {
          'name' => {
            'type' => 'text_field',
            'label' => 'Nombre',
            'placeholder' => 'Community Manager'
          }
        },
        {
          'permissions' => {
            'type' => 'has_many',
            'model' => "Adminpanel::Permission",
            'label' => 'Permisos'
          }
        }
      ]
    end

    def self.display_name
      'Rol'
    end

    def self.icon
      'ticket'
    end
  end
end
