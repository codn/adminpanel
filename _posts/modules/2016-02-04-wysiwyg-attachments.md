---
title: Wysiwyg Attachments
category: module
layout: post
---

To add attachments to a wysiwyg field, you need to mount an uploader with the
name of the relation's model and add `uploader => :text_attachments` to your
wysiwyg hash.


```ruby
mount_uploader :text_attachments

# ...

def self.form_fields
  [
  # ...
  {
    'text' => {
      'type' => 'wysiwyg_field',
      'uploader' => :text_attachments
    }
  }
  ]
end
```
