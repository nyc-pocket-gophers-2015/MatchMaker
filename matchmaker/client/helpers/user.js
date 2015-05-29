var profileComplete = function() {
  var user = Meteor.user();
  if (user.profile.bio == null) {
    console.log("no bio");
  } else {
    console.log("yes bio");
  }
}

// db.users.update(
//   {_id: brendan._id},
//   {
//     $set: {
//       profile: { bio: "14Q3", age: "33" }
//     },
//     $currentDate: { lastModified: true }
//   }
// )