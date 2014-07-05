module Adminpanel
  class Permission < ActiveRecord::Base
    include Adminpanel::Base
    include ApplicationHelper

    enum action: [ :to_read, :to_publish, :to_create, :to_update,
      :to_destroy, :to_manage ]

    belongs_to :rol

    def name
      "#{I18n.t('enum.' + action.to_s)} #{symbol_class(self.resource).display_name}"
    end

    def self.form_attributes
      [
        {
          'rol_id' => {
            'type' => 'belongs_to',
            'label' => 'rol',
            'placeholder' => 'rol',
            'model' => 'Adminpanel::Rol',
            # 'remote_resource' => false
          }
        },
        {
          'action' => {
            'type' => 'enum_field',
            'label' => 'action',
            'placeholder' => 'action',
          }
        },
        {
          'resource' => {
            'type' => 'resource_select',
            'label' => 'resource',
            'placeholder' => 'resource',
          }
        },

      ]
    end

    def self.display_name
      'Permiso' #singular
    end

    def self.icon
      "gavel" # fa-{icon}
    end
  end
end
