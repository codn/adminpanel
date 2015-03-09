ready = ->
  $('tbody#sortable').sortable
    update: (event, ui) ->
      console.log ui.item
      position = 1
      $(@).children('tr').each ->

        if $(@).data('position') == ui.item.data('position')
          row = $(@)
          console.log "new pos: #{position}"
          $.ajax(
            url: "/panel/products/#{$(@).data('id')}/move-position",
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
