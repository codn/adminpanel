class Contact
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor <%= fields.map{|e| ":#{e}" }.join(', ') -%>

<%- if fields.include?('email') -%>
  # validations for email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates_format_of :email, with: VALID_EMAIL_REGEX, message: "#{I18n.t('model.attributes.email')} #{I18n.t('activerecord.errors.messages.invalid')}"
  validates_presence_of :email, message: "#{I18n.t('model.attributes.email')} #{I18n.t('activerecord.errors.messages.blank')}"
  <%- fields.delete('email') -%>
<%- end -%>

<%- fields.each do |field| -%>
  # validations for <%= field %>
  validates_presence_of :<%= field -%>, message: "#{I18n.t('model.attributes.<%= field -%>')} #{I18n.t('activerecord.errors.messages.blank')}"

<%- end -%>

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def self.display_name
    'Mail'
  end

  def self.get_attribute_label(label)
    return label
  end

  def persisted?
    false
  end
end
