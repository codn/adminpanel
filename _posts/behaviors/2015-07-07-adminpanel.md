---
title: Adminpanel
category: behavior
---

# def self.form_attributes
This method is going to be used to generate the form and display the fields in the panel, it must return an array of hashes:

    def self.form_fields
      [{
        'name' => {
          'type' => 'text_field',
          'label' => 'Nickname',
          'placeholder' => 'John Doe',
          'show' => 'index'
        }
      }]
    end

in the example above, `'name'` is the database field, `'type'` is the form type, `'show'` is an extra attribute described below and label and placeholder are that.

### types supported
* `'type' => 'text_field'`
* `'type' => 'adminpanel_file_field'` works for [adminpanel galleries](https://github.com/codn/adminpanel/wiki/Generator-adminpanel:gallery)
* `'type' => 'file_field'` Used for single image input
* `'type' => 'non_image_file_field'` Used for single file inputs like pdfs or documents.
* `'type' => 'wysiwyg_field'`
* `'type' => 'boolean'`
* `'type' => 'number_field'`
* `'type' => 'password_field'`
* `'type' => 'text_area'`
* `'type' => 'date'`
* `'type' => 'enum_field'`
* `'type' => 'resource_select'` Shows all your resources of the setup and lets you choose one
* `'type" => 'select', "options" => Proc.new { |object| Adminpanel::Model.scope }`
* `'type' => 'checkbox', "options" => Proc.new { |object| object.custom_scope }` # you may use the object available to create the scope.

### additional keys and values supported
*  `'show' => 'false'` If you want an attribute that isn't going to be displayed in index and show.
*  `'show' => 'index'` If you want an attribute to be displayed in index only.
*  `'show' => 'show'` If you want an attribute to be displayed in show only.
*  `'remote_resource' => false` This resource isn't going to be created in relations forms, valid when `'type'` is `select` or `checkbox`
*  `'max-files' => 15` This is the maximum number of attachments that `adminpanel/thismodelfile.rb` is going to create.

# def self.routes_options
This method should return a hash with params for the `resources` method in the `routes`, for example

`{ except:[:destroy, :new], path:'super-resource' } `

# def self.member_routes
This methods insert routes inside a member when generating the routes, for restful custom routes.

    [{
      'put' => {
        'path' => :some_controller_method,
        'args' => { as: 'super_action', path: 'super-path' }
      },
      'post' => {
        'path' => :other_controller_method,
        'args' => { as: 'move' }
      }
    }]

Adminpanel is going to insert those routes into:

    resources :model do
      member do
        put :some_controller_methods, { as: 'super_action', path: 'super-path' }
        post :other_controller_method, { as: 'move' }
      end
    end

After this, you'll only need to:
* Implement the method into the corresponding controller
* Add your custom button button to your view.

# def self.collection_routes
#### See member routes, and change for collection

# def self.collection_name
This method returns the string that is going to be shown in the side menu, routes and breadcrumb, by default use the pluraliztion of `self.display_name`
