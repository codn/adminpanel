$(document).on 'click', '.btn.btn-danger.remove-fields', ->
  $('a.add-fields').removeClass 'hidden'

$(document).on 'click', 'a.add-fields', ->
  $collectionContainer = $(@).closest('.file-collection-container')
  maxFiles = $collectionContainer.data('max')
  numberOfFiles = $collectionContainer.find('.product-image:not(.hidden)').length + 1
  if maxFiles != 0 && numberOfFiles > maxFiles
    $(@).addClass('hidden')
