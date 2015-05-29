Template.signup.events({
  'submit #signUpForm': function(e, t) {
    e.preventDefault();

    var signUpForm = $(e.currentTarget),
        email = trimInput(signUpForm.find('#signUpEmail').val().toLowerCase()),
        password = signUpForm.find('#signUpPassword').val(),
        passwordConfirm = signUpForm.find('#signUpPasswordConfirm').val();
        name = signUpForm.find('#signUpName').val(),
        age = signUpForm.find('#signUpAge').val(),
        bio = signUpForm.find('#signUpBio').val(),
        location = signUpForm.find('#signUpLocation').val(),
        gender = signUpForm.find('#signUpGender').val();

    if (isNotEmpty(email) && isNotEmpty(password) && isEmail(email) && areValidPasswords(password, passwordConfirm)) {

      Accounts.createUser({
          email: email,
          password: password,
          profile: {
            name: name,
            age: age,
            bio: bio,
            location: location,
            gender: gender
          }
        }, function(err) {
          console.log("you are in the callback");
          // if (err) {
          //   if (err.message === 'Email already exists. [403]') {
          //     console.log('We are sorry but this email is already used.');
          //   } else {
          //     console.log('We are sorry but something went wrong.');
          //   }
          // } else {
          //   console.log('Congrats new Meteorite, you\'re in!');
          // }
      });
    }
    return false;
  },
});