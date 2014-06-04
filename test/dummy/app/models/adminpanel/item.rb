module Adminpanel
  class Item < ActiveRecord::Base
    include Adminpanel::Base

    belongs_to :product
		belongs_to :category
		    
    def self.form_attributes
      [
        {
          'product_id' => {
            'type' => 'belongs_to',
            'label' => 'product',
            'placeholder' => 'product',
            'model' => 'Adminpanel::Product',
          }
        }, 
        {
          'category_id' => {
            'type' => 'belongs_to',
            'label' => 'category',
            'placeholder' => 'category',
            'model' => 'Adminpanel::Category',
          }
        },

      ]
    end

    def self.display_name
      'Item' #singular
    end

    # def self.icon
    #     "truck" # fa-{icon}
    # end
  end
end
