init_wysiwygs = ->
  $('.wysihtml5').each (i, elem) ->
    $(elem).wysihtml5()

$(document).ready init_wysiwygs
$(document).on 'page:load', init_wysiwygs
