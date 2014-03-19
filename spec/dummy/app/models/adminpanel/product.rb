module Adminpanel
    class Product < ActiveRecord::Base
        attr_accessible :price, :name, :category_ids, :description, :images_attributes
        has_many :categorizations
        has_many :categories, :through => :categorizations, :dependent => :destroy

        mount_images :photos
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
				{"photos" => {"type" => "adminpanel_file_field", "name" => "image"}},
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
