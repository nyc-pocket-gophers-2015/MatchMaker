$(document).ready(function() {
  $('#new_message').submit(function(e){
    e.preventDefault();
    $.ajax({
      url: e.target.action,
      method: e.target.method,
      data: $(e.target).serialize()
    }).done(function(user_id){
      $("#new_message")[0].reset();
    });
  });
});