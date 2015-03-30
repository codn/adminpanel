module Adminpanel
  class Role < ActiveRecord::Base
    include Adminpanel::Base

    has_many :permissions
    has_many :users

    validates_presence_of :name
    validates_uniqueness_of :name

    default_scope do
      includes(:permissions)
    end

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
          'permission_ids' => {
            'label' => 'Permisos',
            'type' => 'checkbox',
            'options' => Proc.new { |object|
              Adminpanel::Permission.all
            },
          }
        }
      ]
    end

    def self.display_name
      I18n.t('model.Role')
    end

    def self.icon
      'ticket'
    end
  end
end
