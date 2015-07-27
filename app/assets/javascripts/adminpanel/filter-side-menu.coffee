$(document).on 'page:load ready', ->
  $('#search-modules').domFilter({
    input: '#search-input'
    selector: '.accordion-group'
  })
