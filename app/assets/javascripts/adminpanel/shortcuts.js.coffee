$(document).on 'keypress', '#remote-form-modal', 'input', (e) ->
  if e.keyCode is 13
    # enter keypress
    $('#remote-form-modal form').submit()
    e.preventDefault()
