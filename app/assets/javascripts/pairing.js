$.ajax({
  url: '/cur_user',
  method: 'GET'
}).done(function(user_id){
  $( document ).delegate( ".voting-forms", "submit", function(e) {
    console.log(e)
    ajaxCallback(e, user_id);
  });
});

function ajaxCallback(e, user_id) {
  e.preventDefault();
  $.ajax({
    url: e.target.action,
    method: e.target.method,
    data: $(e.target).serialize()
  }).done(function(response){
    $.ajax({
      url: '/pairings/new',
      method: 'GET',
      data: { "user_id": user_id }
    }).done(function(response){
      $('.pairing-container').html(response);
      setJSpage();
    });
  });
}