$(document).on('turbolinks:load', function(){

  // toggle arrow on menu items
  // $('.accordion-heading .accordion-toggle').click(function(){
  //   $('.accordion-heading .accordion-toggle').not($(this)[0], '.accordion-heading .accordion-toggle.collapse').addClass('collapsed');
  // });

  // show the overview boxes on the dashboard once they are loaded
  // $('.overview_boxes .box_row').css('display', 'inline-block');

  // init tooltips on .tips class elements, text for the tooltip is in the data-title attribute on the element itself
  $('[data-toggle="tooltip"]').tooltip();

  // init popover on .pop class elements
  // $('.pop').popover({
  //   title:$(this).data('title'),
  //   content:$(this).data('content'),
  //   placement:'top'
  // });

  // prevent the top menu popover links to make the window scroll up because of href="#"
  // $('.visible-desktop #messages, .visible-desktop #notifications').click(function(e){
  //   e.preventDefault();
  // });


  // funtion to slide menu out from the left
  // $('.slide_menu_left').click(function(e){
  //
  //   e.preventDefault();
  //   if($(".nav-collapse.collapse").hasClass('open_left')){
  //     sidemenu_close();
  //   }else{
  //     sidemenu_open();
  //     $('.main_container').bind('click', function(){
  //       sidemenu_close();
  //     });
  //   //   var handler = function() {
  //     //  sidemenu_close();
  //     // };
  //    //  $(window).bind('resize', handler);
  //   }
  // });


  // collapse function for the widget
  // $('.widget-buttons a.collapse').click(function(){
  //   if($(this).attr('data-collapsed') == 'false'){
  //     $(this).closest('.widget').find('.widget-body').slideUp();
  //     $(this).attr('data-collapsed', 'true').addClass('widget-hidden');
  //   }else{
  //     $(this).closest('.widget').find('.widget-body').slideDown();
  //     $(this).attr('data-collapsed', 'false').removeClass('widget-hidden');
  //   }
  // });

  $('.datepicker-basic').datepicker();

});

//-----  Side menu functions -----

  // slide menu out of view
  // function sidemenu_close(){
  //   $(".main_container").stop().animate({
  //       'left': '0'
  //   }, 250, 'swing');
  //   $(".nav-collapse.collapse").stop().animate({
  //       'left': '-150px'
  //   }, 250, 'swing').removeClass('open_left');
  //   $('.main_container').unbind('click');
  //   if(typeof handler != 'undefined'){
  //     $(window).unbind('resize', handler);
  //   }
  // }
  //
  // // slide menu in
  // function sidemenu_open(){
  //     $(".main_container").stop().animate({
  //         'left': '150px'
  //     }, 250, 'swing');
  //     $(".nav-collapse.collapse").stop().animate({
  //         'left': '0'
  //     }, 250, 'swing').addClass('open_left');
  // }
