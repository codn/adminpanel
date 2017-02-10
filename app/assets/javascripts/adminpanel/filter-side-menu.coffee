$(document).on 'turbolinks:load', ->
  $('#search-modules').domFilter
    input: '#search-input'
    selector: '.accordion-group'
