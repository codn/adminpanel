require 'carrierwave'
module Adminpanel
	class Section < ActiveRecord::Base
	  attr_accessible :description, :file, :has_image, :key, :name, :has_description, :images_attributes
	  has_many :images, :foreign_key => "foreign_key", :conditions => { :model => "Section" }
	  accepts_nested_attributes_for :images, :allow_destroy => true
	  mount_uploader :file, SectionUploader
	  validates_length_of :description, :minimum => 10, :on => :update, :if => lambda{|section| section.key == "telephone"}
	  validates_presence_of :description, :on => :update
	end
end