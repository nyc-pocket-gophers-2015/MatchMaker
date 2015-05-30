Template.userHome.helpers({
  friends: function() {
    return Meteor.user().profile.friends;
  }
})