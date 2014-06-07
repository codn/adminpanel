module Adminpanel
  class Department < ActiveRecord::Base
    include Adminpanel::Base

    belongs_to :category

    has_many :items
    has_many :product, :through => :items, :dependent => :destroy

    def self.form_attributes
      [
        {
          'category_id' => {
            'type' => 'belongs_to',
            'label' => 'category',
            'placeholder' => 'category',
            'model' => 'Adminpanel::Category',
          }
        },
        {
          'product_ids' => {
            'type' => 'has_many',
            'label' => 'product',
            'placeholder' => 'product',
            'model' => 'Adminpanel::Product',
          }
        },
        {
          'name' => {
            'type' => 'text_field',
            'label' => 'name',
            'placeholder' => 'name',
          }
        },

      ]
    end

    def self.display_name
      'Departamento' #singular
    end

    # def self.icon
    #     "truck" # fa-{icon}
    # end
  end
end
