Meteor.publish('users', function(groupId) {
  return Meteor.users.find();
});