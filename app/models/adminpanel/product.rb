require "carrierwave"
require "carrierwave/orm/activerecord"

module Adminpanel
  class Product < ActiveRecord::Base
    attr_accessible :description, :name, :images_attributes, :category_id, :brief
    has_many :images, :foreign_key => "foreign_key", :conditions => { :model => "Product" }
    belongs_to :category
    accepts_nested_attributes_for :images, :allow_destroy => true

    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :category_id
    validates_presence_of :brief

    def to_param
    	"#{id} #{name}".parameterize
    end

    def simple_name
        "Product"
    end
  end
end