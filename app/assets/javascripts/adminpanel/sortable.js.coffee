ready = ->
  $('tbody#sortable').sortable
    update: (event, ui) ->
      position = 1
      $(@).children('tr').each ->
        if $(@).data('id') == ui.item.data('id')
          $row = $(@)
          $.ajax(
            url: $row.data('url')
            data:
              position: position
            method: 'put',
            success: ->
              # flash the updated $row
              $row.addClass('success')
              setTimeout ( ->
                $row.removeClass('success')
              ), 500
          )
          return true
        else
          position++
  $('tbody#sortable').disableSelection


$(document).ready(ready)
$(document).on('page:load', ready)
