$(document).ready(function(){
	$('form').on('click', '.add_fields', function(e) {
		e.preventDefault();
		var $collectionContainer = $(this).closest('.file-collection-container');
		var maxFiles = $collectionContainer.data('max');
		var numberOfFiles = $collectionContainer.find('.product-image:not(.hidden)').length + 1;

		if (maxFiles == '0' || numberOfFiles <= maxFiles) {
			time = new Date().getTime();
			regexp = new RegExp($(this).data('id'), 'g');
			$(this).before($(this).data('fields').replace(regexp, time));
		}
	});

	$('form').on('click', '.remove_fields', function(e){
		$(this).prev('input[type=hidden]').val('1');
		$(this).parent().parent().parent().addClass('hidden');
		e.preventDefault();
	});
});
