---
title: Wysiwyg Trix Attachments
category: module
layout: post
---

To add attachments to a wysiwyg field, you need to mount an uploader with the
name of the relation's model and add `uploader => :trixfiles` to your
wysiwyg hash.

# Model
```ruby
mount_uploader :trixfiles

# ...

def self.form_fields
  [
    # ...
    {
      'body' => {
        'type' => 'wysiwyg_field',
        'uploader' => :trixfiles,
        'images' => true,
        'label' => 'Cuerpo',
        'show' => 'false'
      },
    },
  ]
end
```

# text_attachment.rb

```ruby
module Adminpanel
  class Trixfile < Image
    include Adminpanel::Base
    mount_uploader :file, TextAttachmentUploader

  end
end
```

# Controller

```ruby
def whitelisted_params
  params.require(:somet).permit(
    # ...
    trixfile_ids: [],
    # ...
  )
end
```
