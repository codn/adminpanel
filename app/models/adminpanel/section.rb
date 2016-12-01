module Adminpanel
  class Section < ActiveRecord::Base
    include Adminpanel::Base

    mount_images :sectionfiles

    validates_length_of :description,
        minimum: 10,
        maximum: 10,
        allow_blank: true,
        if: :is_a_phone?,
        message: I18n.t('activerecord.errors.messages.not_phone')
    validates_presence_of :description,
        minimum: 9,
        on: :update,
        if: :has_description
    validates_presence_of :key
    validates_presence_of :name
    validates_presence_of :page

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates_format_of :description, with: VALID_EMAIL_REGEX, if: :is_email?, allow_blank: true

    default_scope do
      order order: :asc
    end

    scope :of_page, -> (page) do
      where(page: page)
    end

    scope :with_description, -> do
      where.not(description: '')
    end

    def self.form_attributes
      [
        {'description' => {'name' => 'Descripcion', 'description' => 'label', 'label' => 'Seccion'}},
        {'name' => {'name' => 'name', 'label' => 'Seccion'}},
        {'key' => {'name' => 'key', 'label' => 'Llave'}},
        {'page' => {'name' => 'page'}},
        {'sectionfiles' => {'type' => 'adminpanel_file_field', 'show' => false}},
      ]
    end

    def self.icon
      'tasks'
    end

    def self.display_name
      I18n.t('model.Section')
    end

    def description
      if self.has_description
        return super.try(:html_safe)
      else
        return super
      end
    end

    def self.routes_options
      { path: collection_name.parameterize, except: [:new, :create, :destroy] }
    end

    protected

    def is_email?
      self.key == 'email'
    end

    def is_a_phone?
      self.key == 'phone'
    end
  end
end
