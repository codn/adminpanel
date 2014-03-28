module Adminpanel
  class User < ActiveRecord::Base
    attr_accessible :email, :name, :password, :password_confirmation
    has_secure_password

  #name validations
    validates_presence_of :name
    validates_length_of :name, :maximum => 25

  #password validations
    validates_confirmation_of :password
    validates_presence_of :password
    validates_length_of :password, :minimum => 6

  #password_confirmation validations
    validates_presence_of :password_confirmation

  #email validations
    validates_presence_of :email
    validates_uniqueness_of :email
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates_format_of :email, :with => VALID_EMAIL_REGEX

    before_save{ email.downcase! }
    before_save :create_remember_token

    def has_role?(role_sym)
      roles.any? { |r| r.name.underscore.to_sym == role_sym }
    end

    def self.form_attributes
      [
        {"name" => {"type" => "text_field", "name" => "Nombre", 'label' => "Nombre", "placeholder" => "Nombre"}},
        {"email" => {"type" => "text_field", "name" => "Correo", 'label' => 'Correo', 'placeholder' => 'Correo'}},
        {"password" => {"type" => "password_field", "name" => "Contrasena", 'label' => I18n.t('model.attributes.password'), "placeholder" => I18n.t('model.attributes.password'), 'show' => 'false'}},
        {"password_confirmation" => {"type" => "password_field", "name" => "Confirmacion de contrasena", 'placeholder' => I18n.t('model.attributes.password_confirmation'), 'label' => I18n.t('model.attributes.password_confirmation'), 'show' => 'false'}},
      ]
    end

    def self.display_name
      "Usuario"

    end

    def self.icon
      'icon-user'
    end

    private
      def create_remember_token
        self.remember_token = SecureRandom.base64.tr("+/", "-_")
      end
  end
end
