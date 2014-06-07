module Adminpanel
  class Product < ActiveRecord::Base
    include Adminpanel::Base

    has_many :categorizations
    has_many :categories, :through => :categorizations
    mount_images :photos

    validates_presence_of :name
    validates_presence_of :price
    validates_presence_of :description

    def self.form_attributes


      [
      {"category_ids" => {"type" => "has_many", "model" => "Adminpanel::Category", "name" => "category_ids"}},
      {
        'name' => {
          'type' => 'text_field',
          'label' => 'name',
          'placeholder' => 'name'}
      },
      {
        'price' => {
          'type' => 'text_field',
          'name' => 'price'
        }
      },
      {
        'photos' => {
          'type' => 'adminpanel_file_field',
          'label' => 'photo',
          'placeholder' => 'photo'}
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
