$.ajax({
  url: '/users',
  method: 'GET'
}).done(function(response){
  var users = response

  var substringMatcher = function(users) {
    return function findMatches(q, cb) {
      var matches, substringRegex;

      // an array that will be populated with substring matches
      matches = [];

      // regex used to determine if a string contains the substring `q`
      substrRegex = new RegExp(q, 'i');

      // iterate through the pool of strings and for any string that
      // contains the substring `q`, add it to the `matches` array
      $.each(users, function(i, user) {
        if (substrRegex.test(user.name)) {
          matches.push(user);
        }
      });
      cb(matches);
    };
  };


  $('#typeahead').typeahead({
    hint: true,
    highlight: true,
    minLength: 1
  },
  {
    name: 'users',
    displayKey: 'name',
    source: substringMatcher(users),
    templates: {
      empty: [
        '<div class="empty-message">',
        'Unable to find any users by that query',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<p><a href="users/{{id}}">{{name}}</a></p>')
    }
  });

}).fail(function(error){
  console.log("error");
});



