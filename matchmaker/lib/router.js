Router.configure({
  layoutTemplate: 'layout'
});

Router.route('/', {
});

Router.route('users/:_id', {
  name: 'userPage',
  // data: function() { return Meteor.users.find({_id: this.params._id}); }
});
