var ready = function(){
    $("#gallery-container").imagesLoaded(function(){
        $('#gallery-container').masonry({
                    itemSelector: '.gallery-item',
                    isAnimated:true,
                    animationOptions: {
                        duration: 700,
                        easing:'linear',
                        queue :false
                   }
         });
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);
