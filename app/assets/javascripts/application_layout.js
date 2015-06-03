$(document).bind("mobileinit", function(){
  $.mobile.ajaxEnabled = false;
});

$(document).ready(function(){
  setJSpage();
})

function setJSpage() {
  $('.ui-content').hide().fadeIn(500);
  $('.pairing-title').css({ opacity: 1});
  $('.footer').css({ opacity: 1});
  $(document.body).delegate("form",'submit',function(e){
    $(this).attr("data-ajax", "false");
  });
  var newHeight = window.innerHeight * 0.8;
  $('.ui-content').css({'height': newHeight + "px"});

  $('.vote-control-no').on('click', function() {
    $('.pairing-body').animate({left: "-=600px"}, 350, function(){
      $('.vote-form-no').submit();
    });
  });

  $('.vote-control-yes').on('click', function() {
    $('.pairing-body').animate({left: "+=600px"}, 350, function(){
      $('.vote-form-yes').submit();
    });
  });
}