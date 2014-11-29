ready = ->
	$('.add-fields').on('click', (e) ->
		e.preventDefault()

		time = new Date().getTime()
		regexp = new RegExp($(@).data('id'), 'g')
		$(@).before($(@).data('fields').replace(regexp, time))
	)

	$('.remove-fields').on('click', (e) ->
		$(@).prev('input[type=hidden]').val('1')
		$(@).parent().parent().parent().addClass('hidden')
		e.preventDefault()
	)

$(document).ready(ready)
$(document).on('page:load', ready)
