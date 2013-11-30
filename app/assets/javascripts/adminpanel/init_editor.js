$(document).ready(function(){
	if($(".editable")){

		var editor = new MediumEditor('.editable',{
		 			buttons: [
		 				'bold', 
		 				'italic', 
		 				'underline', 
		 				'anchor', 
		 				'header1', 
		 				'header2', 
		 				'quote', 
		 				'unorderedlist'
	 				]
		});

		$("#save-button").on("click", function(e){
			if(editor.serialize()["element-0"].value.length <= 10){	
				e.preventDefault();
				return false;
			} else {
				$("#description-field").val(editor.serialize()["element-0"].value);
				// e.preventDefault();
				// return false;
			}
		});
	}
})