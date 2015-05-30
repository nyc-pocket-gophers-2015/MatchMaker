Template.userPage.helpers({
  bio: function() {
    return Meteor.user().profile.bio;
  },
  email: function() {
    return Meteor.user().emails[0].address;
  }
});