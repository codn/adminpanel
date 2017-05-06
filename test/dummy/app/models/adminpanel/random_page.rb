module Adminpanel
  class RandomPage < Page
    def self.instance
      first || create!(name: 'Random Page', type: 'Adminpanel::RandomPage')
    end

    mount_images :random_pagefiles

    store :fields, accessors: [
      :header,
      :slogan,
      :body,
    ]

    def self.form_attributes
      [
        {
          'header' => {
            'type' => 'text_field',
            'label' => 'Cabecera'
          }
        },
        {
          'slogan' => {
            'type' => 'text_field',
            'label' => 'Slogan'
          }
        },
        {
          'body' => {
            'type' => 'wysiwyg_field',
            'label' => 'Contenido'
          }
        },
        {
          'random_pagefiles' => {
            'type' => 'adminpanel_file_field',
            'label' => 'Galería'
          }
        }
      ]
    end

    def self.display_name
      'Random Page'
    end

    def self.icon
      'puzzle-piece'
    end

  end
end
