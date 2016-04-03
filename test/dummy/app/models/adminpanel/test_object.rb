module Adminpanel
  class TestObject < ActiveRecord::Base
    include Adminpanel::Base
    has_and_belongs_to_many :categories,
        join_table: "adminpanel_test_object_category"

    mount_images :textfiles

    def self.form_attributes
      [
        {
          'name' => {
            'type' => 'text_field',
            'label' => 'name'
          }
        },
        {
          'category_ids' => {
            'type' => 'checkbox',
            'options' => Proc.new { |object|
              Adminpanel::Category.all.map { |o| [o.id, o.name] }
            }
          }
        },
        {
          'boolean' => {
            'type' => 'boolean',
            'label' => 'boolean'
          }
        },
        {
          'text' => {
            'type' => 'wysiwyg_field',
            'uploader' => 'textfiles',
            'label' => 'wysi'
          }
        },
        {
          'price' => {
            'type' => 'wysiwyg_field',
            'label' => 'wysi'
          }
        },
        {
          'quantity' => {
            'type' => 'number_field',
            'label' => 'wysi'
          }
        },
      ]
    end
  end

  def self.display_name
    'objeto'
  end
end
