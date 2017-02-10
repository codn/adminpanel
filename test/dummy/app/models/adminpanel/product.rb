module Adminpanel
  class Product < ActiveRecord::Base
    include Adminpanel::Base
    include Adminpanel::Facebook
    include Adminpanel::Friendly

    has_many :categorizations
    has_many :categories, through: :categorizations

    mount_images :photos

    validates_presence_of :name
    validates_presence_of :price
    validates_presence_of :description

    def supername
      "Super#{name}"
    end

    def self.form_attributes
      [
      {
        "category_ids" => {
          "type" => "checkbox",
          "options" => Proc.new {|object|
            Adminpanel::Category.all
          }
        }
      },

      {
        'name' => {
          'type' => 'text_field',
          'label' => 'name',
          'placeholder' => 'name'}
      },
      {
        'price' => {
          'type' => 'text_field',
        }
      },
      {
        'photos' => {
          'type' => 'adminpanel_file_field',
          'label' => 'photo',
          'placeholder' => 'photo',
          'max-files' => 2
        }
      },
      {
        'description' => {
          'type' => 'wysiwyg_field',
          'label' => 'description',
          'placeholder' => 'description'
        }
      },
      ]
    end

    def self.display_name
      "Producto"
    end

    def self.icon
      "icon-truck"
    end
  end
end
