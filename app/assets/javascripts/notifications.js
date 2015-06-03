$.ajax({
  url: '/cur_user',
  method: 'GET'
}).done(function(response){
  $('div.notification').hide()


  var pusher = new Pusher('1115c4a31fc8d8f80c44');

  //subscribe to our notifications channel
  var notificationsChannel = pusher.subscribe('notifications' + response);
  console.log(notificationsChannel)

  //do something with our new information
  notificationsChannel.bind('new_notification', function(notification){
    // assign the notification's message to a <div></div>
    var message = notification.message;
    $('.notification').show()
    $('.notification').text(message);
    setTimeout(function() {
      $('div.notification').hide()
    }, 3000)
  });

  $('.submit-notification').on('click', sendNotification);
});

var sendNotification = function(){
  console.log("FIRED")

  // get the contents of the input
  // var text = $('input.create-notification').val();

  // POST to our server
  $.post('/notifications/create', {message: "text"}).success(function(){
    console.log('Notification sent!');
  });
};
