module Adminpanel
  class Department < ActiveRecord::Base
    include Adminpanel::Base

    belongs_to :category

    has_many :items
    has_many :product, through: :items, dependent: :destroy

    def self.form_attributes
      [
        {
          'category_id' => {
            'type' => 'select',
            'placeholder' => 'category',
            'options' => Proc.new { |object|
              Adminpanel::Category.all
            }
          }
        },
        {
          'product_ids' => {
            'type' => 'checkbox',
            'placeholder' => 'product',
            'options' => Proc.new { |object|
              Adminpanel::Product.all
            }
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
