module Adminpanel
  class Category < ActiveRecord::Base
    # attr_accessible :name, :model #, :product_ids

    validates_presence_of :model
    validates_presence_of :name
    validates_uniqueness_of :name


    # has_many :categorizations
    # has_many :products, :through => :categorizations, :dependent => :destroy


    def self.form_attributes
      [
  		  # {
        # 'product_ids' => {
        #   'type' => 'has_many',
        #   'model' => 'Adminpanel::Product',
        #   'name' => 'product_ids'
        #   }
        # },
    		{
          'name' => {
            'type' => 'text_field',
            'name' => 'name',
            'label' => 'name',
            'placeholder' => 'name'
          }
        },
      ]
    end

    def self.display_name
      "Categorías"
    end

    def self.icon
        "icon-bookmark"
    end

    default_scope { order("model ASC")}
    scope :of_model, lambda{|model| where(:model => model)}
  end
end
