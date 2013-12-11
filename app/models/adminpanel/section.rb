require 'carrierwave'
require 'carrierwave/orm/activerecord'
module Adminpanel
	class Section < ActiveRecord::Base
	  attr_accessible :description, :has_image, :key, :name, :has_description, :images_attributes
	  has_many :images, :foreign_key => "foreign_key", :conditions => { :model => "Section" }
	  accepts_nested_attributes_for :images, :allow_destroy => true
	  validates_length_of :description, :minimum => 10, :maximum => 10, :on => :update, :if => lambda{|section| section.key == "telephone"}
	  validates_presence_of :description, :minimum => 9, :on => :update, :if => lambda{|section| section.has_description == true}
	  validates :description, :numericality => { :only_integer => true }, :on => :update, :if => lambda{|section| section.key == "telephone"}
	  validates_presence_of :key
	  validates_presence_of :name

	  def simple_name
	  	"Section"
	  end
	end
end