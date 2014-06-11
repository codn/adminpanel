$(document).on 'click', 'a.accordion-toggle', ->
  $( this ).attr 'data-clicked', true

$(document).on 'page:fetch', ->
  $('a.accordion-toggle[data-clicked="true"]').children('i:first').toggleClass('hidden')
  $('a.accordion-toggle[data-clicked="true"]').prepend '<i class="fa fa-spinner fa-spin"></i>'

$(document).on 'page:restore', ->
  $('a.accordion-toggle[data-clicked="true"]').children('i:first').remove()
  $('a.accordion-toggle[data-clicked="true"]').children('i:first').toggleClass 'hidden'
  $('a.accordion-toggle[data-clicked="true"]').data 'clicked', false
