$(document).on 'click', '.add-fields', (e) ->
  # add image inside a form click
  e.preventDefault()

  time = new Date().getTime()
  regexp = new RegExp($(@).data('id'), 'g')
  $(@).before($(@).data('fields').replace(regexp, time))

$(document).on 'click', '.remove-fields', (e) ->
  # remove image inside a form click
  e.preventDefault()
  $(@).prev('input[type=hidden]').val('1')
  $(@).parent().parent().parent().addClass('hidden')
