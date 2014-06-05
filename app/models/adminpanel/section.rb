require 'carrierwave'
require 'carrierwave/orm/activerecord'
module Adminpanel
	class Section < ActiveRecord::Base
		include Adminpanel::Base

	  mount_images :images

	  validates_length_of :description,
				minimum: 10,
				maximum: 10,
				on: :update,
				if: :is_a_phone?,
				message: I18n.t('activerecord.errors.messages.not_phone')
	  validates_presence_of :description,
				minimum: 9,
				on: :update,
				if: lambda{|section| section.has_description == true }
	  validates :description,
				numericality: { only_integer: true },
				on: :update,
				if: :is_a_phone?
	  validates_presence_of :key
	  validates_presence_of :name
	  validates_presence_of :page

		VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
		validates_format_of :description, with: VALID_EMAIL_REGEX, if: lambda{|section| section.key == 'email'}

	  default_scope { order("page ASC") }

	  scope :of_page, lambda{ |page|
			where(page: page)
		}

	  scope :with_description, -> { where.not( description: '') }

		def self.form_attributes
			[
				{'description' => {'name' => 'Descripcion', 'description' => 'label', 'label' => 'Seccion'}},
				{'name' => {'name' => 'name', 'label' => 'Seccion'}},
				{'key' => {'name' => 'key', 'label' => 'Llave'}},
				{'page' => {'name' => 'page'}},
			]

		end

	  def self.icon
	  	'tasks'
	  end

		def self.display_name
			'Seccion'
		end

		def description
			if self.has_description && !self.attributes['description'].nil?
				return self.attributes['description'].html_safe
			else
				return self.attributes['description']
			end
		end

		private
		def is_a_phone?
			key == 'phone' && description != ''
		end
	end
end
