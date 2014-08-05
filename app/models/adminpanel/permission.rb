module Adminpanel
  class Permission < ActiveRecord::Base
    include Adminpanel::Base
    include ApplicationHelper

    enum action: [ :to_read, :to_publish, :to_create, :to_update,
      :to_destroy, :to_manage ]

    belongs_to :rol

    def name
      "#{action} #{symbol_class(self['resource']).display_name}"
    end

    # def action
    #   Permission.actions.each do |key, value|
    #     return I18n.t("permission.#{key}") if value == self['action']
    #   end
    # end

    # def resource
    #   symbol_class(self['resource']).display_name.to_s.pluralize(I18n.default_locale)
    # end

    def self.form_attributes
      [
        {
          'rol_id' => {
            'type' => 'belongs_to',
            'label' => I18n.t('permission.rol'),
            'model' => 'Adminpanel::Rol',
            # 'remote_resource' => false
          }
        },
        {
          'action' => {
            'type' => 'enum_field',
            'label' => I18n.t('permission.action'),
          }
        },
        {
          'resource' => {
            'type' => 'resource_select',
            'label' => I18n.t('permission.resource'),
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
