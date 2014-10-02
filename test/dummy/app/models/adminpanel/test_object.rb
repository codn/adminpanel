module Adminpanel
  class TestObject < ActiveRecord::Base
    include Adminpanel::Base
    has_and_belongs_to_many :categories,
        join_table: "adminpanel_test_object_category"
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
            'type' => 'has_many',
            'model' => 'Adminpanel::Category',
            'label' => 'has_many'
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
end
