---
title: Wysiwyg Attachments
category: module
layout: post
---

To add attachments to a wysiwyg field, you need to mount an uploader with the
name of the relation's model and add `uploader => :text_attachments` to your
wysiwyg hash.

# Model
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

# text_attachment.rb

```ruby
module Adminpanel
  class TextAttachment < Image
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
    text_attachmentt_ids: [],
    # ...
  )
end
```
