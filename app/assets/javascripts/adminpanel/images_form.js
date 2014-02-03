$(document).ready(function(){
	$('form').on('click', '.add_fields', function(e) {
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$(this).before($(this).data('fields').replace(regexp, time));
		e.preventDefault();
	});

	$('form').on('click', '.remove_fields', function(e){
		$(this).prev('input[type=hidden]').val('1');
		$(this).parent().parent().parent().hide();
		e.preventDefault();
	});
});