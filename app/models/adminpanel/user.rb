class Admin::User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password

#name validations
  validates_presence_of :name

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

  private
    def create_remember_token
      self.remember_token = SecureRandom.base64.tr("+/", "-_")
    end
end
