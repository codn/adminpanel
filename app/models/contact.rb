class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :subject, :body

  validates_presence_of :name, message: "#{I18n.t('model.attributes.name')} #{I18n.t('activerecord.errors.messages.blank')}"
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, :with => VALID_EMAIL_REGEX, message: "#{I18n.t('model.attributes.email')} #{I18n.t('activerecord.errors.messages.invalid')}"
  validates_presence_of :body, message: "#{I18n.t('model.attributes.body')} #{I18n.t('activerecord.errors.messages.blank')}"

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def self.display_name
    'Correo'
  end

  def self.get_attribute_label(label)
    return label
  end

  def persisted?
    false
  end
end
