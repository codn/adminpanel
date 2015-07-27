$.fn.domFilter = (options) ->
  $input = $(options['input'])

  $elementsContainer = $(@)
  for selector in options['selector'].split(' ')
    $elementsContainer = $elementsContainer.children(selector)

  $(options['input']).on 'keyup change', ->
    inputVal = $input.val().toUpperCase()
    $elementsContainer.each ->
      filterString = String($(@).data('filter'))
      if typeof $(@).data('no-filter') isnt 'undefined' or filterString.toUpperCase().indexOf(inputVal) > -1
        $(@).show()
      else
        $(@).hide()
