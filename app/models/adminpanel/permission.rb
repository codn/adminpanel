module Adminpanel
  class Permission < ActiveRecord::Base
    include Adminpanel::Base
    include ApplicationHelper

    enum action: [
                  :to_read,
                  :to_publish,
                  :to_create,
                  :to_update,
                  :to_destroy,
                  :to_manage
                ]

    belongs_to :role, touch: true

    # validates_presence_of :action
    validates_presence_of :role_id
    validates_presence_of :resource

    def name
      "#{self.role.name}: #{I18n.t("#{self.class.name.demodulize.downcase}.#{self.action}")} #{self['resource']}"
    end

    def self.form_attributes
      [
        {
          'role_id' => {
            'type' => 'select',
            'label' => I18n.t('permission.role'),
            'options' => Proc.new {|object| Adminpanel::Role.all }
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
      I18n.t('model.Permission') # singular
    end

    def self.icon
      'gavel' # fa-{icon}
    end
  end
end
