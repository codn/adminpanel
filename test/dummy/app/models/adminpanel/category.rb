module Adminpanel
  class Category < ActiveRecord::Base
    include Adminpanel::Base
    validates_presence_of :model
    validates_presence_of :name

    has_many :categorizations
    has_many :products, :through => :categorizations, :dependent => :destroy

    has_many :mugs

    has_and_belongs_to_many :test_objects,
        join_table: "adminpanel_test_object_category"

    def self.form_attributes
      [
        {"name" => {"type" => "text_field", "name" => "name", "label" => "name", "placeholder" => "name"}},
        # {'model' => {"type" => "text_field", "name" => "name", "label" => "name", "placeholder" => "name", 'show' => 'false'}},
        {
          'mug_ids' => {
            'type' => 'select',
            "options" => Proc.new { |category|
              [["Mérida y alrededores", [["Tour de prueba merida 2", 8], ["Tour de prueba merida 1", 6]]], ["Playa del Carmen", [["Tour de prueba playa 1", 7], ["Tour de prueba playa 2", 9]]]]
            },
            'grouped' => true,
            'multiple' => true,
            'remote_resource' => false
          }
        }
      ]
    end

    def self.display_name
        "Categoria"
    end

    def self.icon
        "icon-truck"
    end
  end
end
