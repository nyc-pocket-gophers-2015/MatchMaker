profileComplete = function() {
  var user = Meteor.user();
  if (!user.profile.bio || !user.profile.age || !user.profile.gender || !user.profile.location || !user.profile.name ) {
    console.log("not complete");
  } else {
    console.log("yes complete");
  }
}

// db.users.update(
//   {_id: brendan._id},
//   {
//     $set: {
//       profile: { bio: "14Q3", age: "33", location: "NYC", gender: "Male", name: "Brendan Miranda"}
//     },
//     $currentDate: { lastModified: true }
//   }
// )

// db.users.update(
//   {_id: "D3fjRhDgPgnpHtRQR"},
//   {
//     $set: {
//       profile: { bio: "14Q3", age: "33", location: "NYC", gender: "Male", name: "Brendan Miranda"}
//     },
//     $currentDate: { lastModified: true }
//   }
// )


// db.users.update(
//   {_id: "D3fjRhDgPgnpHtRQR"},
//   {
//     $unset: {
//       category: ""
//     },
//     $currentDate: { lastModified: true }
//   }
// )