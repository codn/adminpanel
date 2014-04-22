require 'carrierwave'
require 'carrierwave/orm/activerecord'
module Adminpanel
	class Section < ActiveRecord::Base

	  mount_images :images

	  validates_length_of :description, :minimum => 10, :maximum => 10, :on => :update, :if => lambda{|section| section.key == I18n.t('key.telephone')}
	  validates_presence_of :description, :minimum => 9, :on => :update, :if => lambda{|section| section.has_description == true}
	  validates :description, :numericality => { :only_integer => true }, :on => :update, :if => lambda{|section| section.key == I18n.t('key.telephone')}
	  validates_presence_of :key
	  validates_presence_of :name
	  validates_presence_of :page

	  default_scope { order("page ASC")}

	  scope :of_page, lambda{|page| where(:page => page)}

		def self.form_methods
			[
				{'description' => {'name' => 'Descripcion'}},
				{'name' => {'name' => 'name'}},
				{'key' => {'name' => 'key'}},
				{'page' => {'name' => 'page'}},
				# {'key' => {'name' => 'key'}},
			]

		end

	  def self.icon
	  	"icon-tasks"
	  end

		def self.display_name
			'Secciones'
		end
	end
end
