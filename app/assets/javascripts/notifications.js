$.ajax({
  url: '/cur_user',
  method: 'GET',
  datatype: 'json'
}).done(function(response){
  console.log(response);
  $('div.notification').hide()


  var pusher = new Pusher('1115c4a31fc8d8f80c44');

  //subscribe to our notifications channel
  var notificationsChannel = pusher.subscribe('notifications' + response.id);
  console.log(notificationsChannel)
  debugger;
  for(var i = 0; i < response.chat_ids.length; i++) {
    var chatChannel = pusher.subscribe('chat' + response.chat_ids[i]);
  }
  // var chatChannel = push.subscribe('conversation' + )

  //do something with our new information
  chatChannel.bind('new_message', function(msg){
    var template = Handlebars.compile(messageTemplate);
    var html = template(msg);
    $('.msg-container').append(html);
    // assign the notification's message to a <div></div>
  });

  notificationsChannel.bind('new_notification', function(notification){
    // assign the notification's message to a <div></div>
    var message = notification.message;
    $('.notification').text(message);
    $('.notification').slideDown()
    setTimeout(function() {
      $('div.notification').slideUp()
    }, 6000)
  });

  $('.submit-notification').on('click', sendMsg);
});

var sendNotification = function(){
  console.log("FIRED")

  // get the contents of the input
  // var text = $('input.create-notification').val();

  // POST to our server
  $.post('/notifications', {message: "text"}).success(function(){
    console.log('Notification sent!');
  });
};

var sendMsg = function(){
  console.log("msgfired")

  // get the contents of the input
  // var text = $('input.create-notification').val();

  // POST to our server
  // $.post('/messages', {message: { content: "text", user_id: 1, chat_id: 1 } }).success(function(){
  //   console.log('Notification sent!');
  // });
};