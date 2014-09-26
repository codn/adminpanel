$(document).on 'click', 'a.spinner-link', ->
  $( this ).attr 'data-clicked', true

$(document).on 'page:fetch', ->
  $('a.spinner-link[data-clicked="true"]').children('i:first').toggleClass('hidden')
  $('a.spinner-link[data-clicked="true"]').prepend '<i class="fa fa-spinner fa-spin"></i>'

$(document).on 'page:restore', ->
  $('a.spinner-link[data-clicked="true"]').children('i:first').remove()
  $('a.spinner-link[data-clicked="true"]').children('i:first').toggleClass 'hidden'
  $('a.spinner-link[data-clicked="true"]').attr 'data-clicked', false
