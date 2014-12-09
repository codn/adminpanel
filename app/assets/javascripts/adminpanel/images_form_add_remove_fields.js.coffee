$(document).on 'click', '.add-fields', (e) ->
	e.preventDefault()

	time = new Date().getTime()
	regexp = new RegExp($(@).data('id'), 'g')
	$(@).before($(@).data('fields').replace(regexp, time))

$(document).on 'click', '.remove-fields', (e) ->
	# $('.remove-fields').on('click', (e) ->
	console.log 'remove fields clicked'
	e.preventDefault()
	$(@).prev('input[type=hidden]').val('1')
	$(@).parent().parent().parent().addClass('hidden')

# $(document).ready(ready)
# $(document).on('page:load', ready)
