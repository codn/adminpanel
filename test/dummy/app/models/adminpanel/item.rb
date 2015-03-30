module Adminpanel
  class Item < ActiveRecord::Base
    include Adminpanel::Base

    belongs_to :product
    belongs_to :category

    def self.form_attributes
      [
        {
          'product_id' => {
            'type' => 'select',
            'placeholder' => 'product',
            'options' => Proc.new {|object|
              Adminpanel::Product.all {|o| [o.id, o.name] }
            }
          }
        },
        {
          'category_id' => {
            'type' => 'select',
            'placeholder' => 'category',
            'options' => Proc.new {|object|
              Adminpanel::Category.all {|o| [o.id, o.name] }
            }
          }
        },

      ]
    end

    def self.display_name
      'Artículo espacios Mayusculas Y ácento' #singular
    end

    # def self.icon
    #     "truck" # fa-{icon}
    # end
  end
end
