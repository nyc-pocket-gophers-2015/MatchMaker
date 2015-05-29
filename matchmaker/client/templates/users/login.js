Template.login.events({
  'submit #login-form': function(e, t) {
    e.preventDefault();

    var login = $(e.currentTarget),
      email = trimInput(login.find('#login-email').val().toLowerCase()),
      password = login.find('#login-password').val();
    if (isNotEmpty(email) && isEmail(email) && isNotEmpty(password) && isValidPassword(password)) {

      Meteor.loginWithPassword(email, password, function(err) {
        if (err) {
          console.log('These credentials are not valid.');
        } else {
          console.log('Welcome back Meteorite!');
        }
      });

    }
    return false;
  },
});