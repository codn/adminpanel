document.addEventListener "trix-attachment-add", (event) ->
  attachment = event.attachment
  if attachment.file
    return uploadAttachment(event)

document.addEventListener "trix-attachment-remove", (event) ->
  image_url = event.attachment.attachment.preloadedURL
  $("input[data-url='#{image_url}']").remove()

uploadAttachment = (e) ->
  $element = $(e.srcElement)
  $form = $('form:first')
  host = $form.data('trix-url')
  attachment = e.attachment
  file = attachment.file
  formData = new FormData
  formData.append("parent_object_class", $form.data('parent-class'))
  formData.append("model", $element.data('uploader-class'))
  formData.append("file", file)

  xhr = new XMLHttpRequest
  xhr.open("POST", host, true)

  xhr.upload.onprogress = (event) ->
    progress = event.loaded / event.total * 100
    return attachment.setUploadProgress(progress)

  xhr.onload = ->
    if (xhr.status is 204 || xhr.status is 200)
      response = JSON.parse(xhr.responseText)

      uploader = $element.data('uploader-name')
      console.log $element
      console.log uploader
      $form.append("<input type=\"hidden\" name=\"#{$form.data('params-key')}[#{uploader.slice(0, -1)}_ids][]\" value=\"#{response.id}\" />")
      return attachment.setAttributes({
        url:  response.image_url,
        href: response.image_url
      })

  xhr.setRequestHeader(
    "X-CSRF-Token",
    $('meta[name="csrf-token"]').attr('content')
  )
  return xhr.send(formData)
