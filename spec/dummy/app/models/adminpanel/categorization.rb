module Adminpanel
  class Categorization < ActiveRecord::Base
    attr_accessible :product_id, :category_id

    belongs_to :product
    belongs_to :category


    def self.form_attributes
        [
		      {"product_id" => {"type" => "belongs_to", "model" => "Adminpanel::Product", "name" => "product_id"}},
		      {"category_id" => {"type" => "belongs_to", "model" => "Adminpanel::Category", "name" => "category_id"}},
        ]
    end

    def self.display_name
        "Categorization"
    end

    # def self.icon
    #     "icon-truck"
    # end
  end
end
