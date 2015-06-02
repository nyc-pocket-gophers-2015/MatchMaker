$(document).bind("mobileinit", function(){
  $.mobile.ajaxEnabled = false;
});

$(document).ready(function(){
  $('.vote-control-no').on('click', function() {
    $('.vote-form-no').submit();
  });

  $('.vote-control-yes').on('click', function() {
    $('.vote-form-yes').submit();
  });
})