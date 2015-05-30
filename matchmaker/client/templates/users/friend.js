Template.friend.helpers({
  name: function() {
    console.log(this.profile.name);
    return this.profile.name;
  },
  gravatarUrl: function(){
    return this.profile.gravatarUrl;
  }
})