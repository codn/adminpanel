module Adminpanel
    class Product < ActiveRecord::Base
        attr_accessible :price, :name, :category_ids, :description, :images_attributes
        has_many :images, :foreign_key => "foreign_key", :conditions => { :model => "product" }
        has_many :categorizations
        has_many :categories, :through => :categorizations, :dependent => :destroy

		accepts_nested_attributes_for :images, :allow_destroy => true
		#remember to change the relationship if you change this model display_name

        validates_presence_of :name
        validates_presence_of :description
        validates_presence_of :price

        def self.form_attributes
            [
                {"category_ids" => {"type" => "has_many", "model" => "Adminpanel::Category", "name" => "category_ids"}},
				{"price" => {"type" => "text_field", "name" => "price", "label" => "price", "placeholder" => "price"}},
				{"name" => {"type" => "text_field", "name" => "name", "label" => "name", "placeholder" => "name"}},
				{"description" => {"type" => "wysiwyg_field", "name" => "description", "label" => "description", "placeholder" => "description"}},
				{"image" => {"type" => "adminpanel_file_field", "name" => "image"}},
            ]
        end

        def self.display_name
            "Product"
        end

        # def self.icon
        #     "icon-truck"    
        # end
    end
end