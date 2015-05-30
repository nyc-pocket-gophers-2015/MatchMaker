
if (Meteor.users.find().count() === 0) {
  console.log("Hey, it's running!!!!!!!!!!!")
  Accounts.createUser({
    email: "doralypantaleon@gmail.com",
    password: "123456",
    profile: {
      name: "Dora",
      age: "25",
      bio: "I'm super old",
      location: "NYC",
      gender: "Female",
      // gravatarUrl: Gravatar.imageUrl("doralypantaleon@gmail.com"),
      friends: []
    }
  });

  Accounts.createUser({
    email: "me@at.com",
    password: "123456",
    profile: {
      name: "Alex",
      age: "23",
      bio: "I'm super duper old",
      location: "NYC",
      gender: "Male",
      friends: []
    }
  });
  Accounts.createUser({
    email: "me@bm.com",
    password: "123456",
    profile: {
      name: "Brendan",
      age: "33",
      bio: "I'm the oldest of them all",
      location: "NYC",
      gender: "Male",
      friends: []
    }
  });
  Accounts.createUser({
    email: "me@tt.com",
    password: "123456",
    profile: {
      name: "Tanya",
      age: "25",
      bio: "Life is cool",
      location: "NYC",
      gender: "Female",
      friends: []
    }
  });
  Accounts.createUser({
    email: "me@sn.com",
    password: "123456",
    profile: {
      name: "Sherman",
      age: "23",
      bio: "Food for life, and also me",
      location: "NYC",
      gender: "Male",
      friends: []
    }
  });
}
