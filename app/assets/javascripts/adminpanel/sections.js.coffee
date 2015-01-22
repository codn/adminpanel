$(document).on 'click', 'a.add-fields', ->
  # add image on sections form
  $collectionContainer = $(@).closest('.file-collection-container')
  maxFiles = $collectionContainer.data('max')
  numberOfFiles = $collectionContainer.find('.product-image:not(.hidden)').length + 1
  if maxFiles != 0 && numberOfFiles > maxFiles
    $(@).addClass('hidden')

$(document).on 'click', '.btn.btn-danger.remove-fields', ->
  # remove image on sectiosn form
  $('a.add-fields').removeClass 'hidden'
