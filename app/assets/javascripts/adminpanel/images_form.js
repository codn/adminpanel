var ready = function(){
	$('form').on('click', '.add-fields', function(e) {
		e.preventDefault();
		
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$(this).before($(this).data('fields').replace(regexp, time));
	});

	$('form').on('click', '.remove-fields', function(e){
		$(this).prev('input[type=hidden]').val('1');
		$(this).parent().parent().parent().addClass('hidden');
		e.preventDefault();
	});
}

$(document).ready(ready);
$(document).on('page:load', ready);
