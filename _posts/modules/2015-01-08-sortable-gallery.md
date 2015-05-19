---
title: Sortable Gallery
category: module
---

This concern is used to make the 'gallery' (or files) of an instantce orderable (you'll be able to order them when viewing a member [show action]).

We'll take `Adminpanel::Post` as an example implementation.

Given that your `Adminpanel::Post` alredy have mounted gallery (with `mount_images :postfiles`)

In `adminpanel/postfile.rb` define:

    belongs_to :post

    def self.relation_field
      'post_id' #this is the parent model reference
    end

    def self.display_name
      'postfiles'
    end

After that, you'll have to:
* Create `adminpanel/postfiles_controller.rb`
* Add a `position`(integer) database field to `postfile.rb`.
* Add `include Adminpanel::SortableGallery` in `postfile.rb`

With this, you are free to call `@post.postfiles.ordered` and are going to be scoped by position
