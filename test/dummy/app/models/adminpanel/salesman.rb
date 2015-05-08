module Adminpanel
  class Salesman < ActiveRecord::Base
    include Adminpanel::Base
    include Adminpanel::Facebook
    include Adminpanel::Twitter

    belongs_to :product

    def self.form_attributes
      [
        {
          'name' => {
            'type' => 'text_field',
            'label' => 'name',
            'placeholder' => 'name'
          }
        },
        {
          'product_id' => {
            'type' => 'select',
            'label' => 'product_id',
            'options' => Proc.new { |object| Adminpanel::Product.all },
            'name_method' => :supername
          }
        },
      ]
    end

    def self.display_name
      'Agente' #singular
    end

    # def self.icon
    #     "truck" # fa-{icon}
    # end
  end
end
