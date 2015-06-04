$.ajax({
  url: '/cur_user',
  method: 'GET'
}).done(function(user){
  $( document ).delegate( ".voting-forms", "submit", function(e) {
    console.log(e)
    ajaxCallback(e, user);
  });
});

function ajaxCallback(e, user) {
  e.preventDefault();
  $.ajax({
    url: e.target.action,
    method: e.target.method,
    data: $(e.target).serialize()
  }).done(function(response){
    debugger;
    $.ajax({
      url: '/pairings/new',
      method: 'GET',
      data: { "user_id": user.id }
    }).done(function(response){
      $('.pairing-container').html(response);
      setJSpage();
    });
  });
}