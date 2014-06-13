module Adminpanel
  class Mug < ActiveRecord::Base
    include Adminpanel::Base
    
    validates_presence_of :name

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
        'number' => {
          'type' => 'number_field',
          'label' => 'number',
          'placeholder' => 'number'
        }
      },
      ]
    end

    def self.display_name
      'Taza' #singular
    end

    # def self.icon
    #     "truck" # fa-{icon}
    # end

    def self.routes_options
      { except:[:new, :create, :edit, :update, :destroy, :show], path:'tazas'}
    end
  end
end
