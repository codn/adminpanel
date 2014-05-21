$(document).on 'click', 'a.accordion-toggle', ->
  $( this ).attr('data-clicked', true)


$(document).on 'page:fetch', ->
  $('a.accordion-toggle[data-clicked="true"]').children('i:first').toggleClass('hidden')
  $('a.accordion-toggle[data-clicked="true"]').prepend('<i class="fa fa-spinner fa-spin"></i>')
  $('a.accordion-toggle[data-clicked="true"]').attr('data-clicked', false)

$(document).on 'page:load', ->
  $('a.accordion-toggle[data-clicked="true"]').children('i:first').remove()
  $('a.accordion-toggle[data-clicked="true"]').children('i:first').toggleClass('hidden')
  $('a.accordion-toggle[data-clicked="true"]').attr('data-clicked', false)
  # console.log $('a.accordion-toggle[data-clicked="true"]')

  # alert 'finished loding'
