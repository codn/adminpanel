ready = ->
  $('tbody#sortable').sortable
    update: (event, ui) ->
      position = 1
      $(@).children('tr').each ->

        if $(@).data('position') == ui.item.data('position')
          row = $(@)
          $.ajax(
            url: row.data('url')
            data:
              position: position
            method: 'put',
            success: ->
              # flash the updated row
              row.addClass('success')
              setTimeout ( ->
                row.removeClass('success')
              ), 500
          )
        else
          position++
  $('tbody#sortable').disableSelection

$(document).ready(ready)
$(document).on('page:load', ready)
