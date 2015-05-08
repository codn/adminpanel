module Adminpanel
  class User < ActiveRecord::Base
    include Adminpanel::Base
    has_secure_password
    belongs_to :role, touch: true

    default_scope do
      includes(:role)
    end

    #role validation
    validates_presence_of :role_id

    #name validations
    validates_presence_of :name
    validates_length_of :name, maximum: 25

    #password validations
    validates_confirmation_of :password, on: :create
    validates_presence_of :password, on: :create
    validates_length_of :password, minimum: 6, on: :create

    #password_confirmation validations
    validates_presence_of :password_confirmation, on: :create

    #email validations
    validates_presence_of :email
    validates_uniqueness_of :email
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates_format_of :email, with: VALID_EMAIL_REGEX

    before_save{ email.downcase! }
    before_save :create_remember_token

    def self.form_attributes
      [
        {
          'name' => {
            'type' => 'text_field',
            'label' => 'Nombre',
            'placeholder' => 'Nombre'
            }
        },
        {
          'email' => {
            'type' => 'email_field',
            'label' => 'Correo',
            'placeholder' => 'Correo'
          }
        },
        {
          'password' => {
            'type' => 'password_field',
            'label' => I18n.t('model.attributes.password'),
            'placeholder' => I18n.t('model.attributes.password'),
            'show' => 'false'
          }
        },
        {
          'password_confirmation' => {
            'type' => 'password_field',
            'placeholder' => I18n.t('model.attributes.password_confirmation'),
            'label' => I18n.t('model.attributes.password_confirmation'),
            'show' => 'false'
          }
        },
        {
          'role_id' => {
            'type' => 'select',
            'options' => Proc.new { |user| Role.all },
            'label' => I18n.t('model.attributes.role_id')
          }
        },
      ]
    end

    def self.new_remember_token
      SecureRandom.urlsafe_base64
    end

    def self.digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def self.display_name
      I18n.t('model.User')
    end

    def self.icon
      'user'
    end

    private
      def create_remember_token
        self.remember_token = User.digest(User.new_remember_token)
      end
  end
end
