emails = [
["alex.taber0@gmail.com","Male"],
["aris.a.perez@gmail.com", "Male"],
["me@brendanmiranda.com", "Male"],
["doralyp@me.com", "Female" ],
["echenique11@gmail.com", "Male"],
["scottbwarner@gmail.com", "Male"],
["sid.watal@gmail.com", "Male"],
["ayme.alvarez@gmail.com", "Female"],
["angiegrace84@gmail.com", "Female"],
["nlee43@gmail.com", "Male"],
["stauntonsample@gmail.com","Male"],
["manentea@gmail.com", "Male"],
["samantha.belkin@gmail.com", "Female"],
["mmschneerson@gmail.com", "Male"],
["marc.cardacci@gmail.com", "Male"],
["lauris.bernhart@gmail.com", "Male" ],
["julia.castro@outlook.com", "Female"],
["sixthand6th@gmail.com", "Male"],
["sheld0ri@gmail.com"], "Male",
["gechrod@gmail.com", "Female"],
["arthur.ross.wilson@gmail.com", "Male"],
["bkmorimoto@gmail.com", "Male"],
["deborah.a.milburn@gmail.com", "Female"],
["ben.costolo@gmail.com", "Male"],
["luciankahn@gmail.com", "Male"],
["tara.c.frye@gmail.com", "Female"],
["charles.green88@gmail.com", "Male"],
["imharrypark@gmail.com", "Male"],
["cetswanson@gmail.com", "Male"],
["ayakokurushima@gmail.com", "Female"],
["ginny.w.martin@gmail.com", "Female"],
["grace.yasukawa@gmail.com", "Female"],
["emilygerngross@gmail.com", "Female"],
["iring.ma@gmail.com", "Female"],
["ling.giang@gmail.com", "Female"],
["lkim3182@gmail.com", "Female"],
["sara.gilford@gmail.com", "Female"],
["thegrandnumber@gmail.com", "Female"],
["mary.c.baylis@gmail.com", "Female"],
["jldennison@gmail.com", "Female"],
["schmidtsusanr@gmail.com", "Female"]
]

def find_gravatar_url(user)
  hash = Digest::MD5.hexdigest(user.email)
  return "http://www.gravatar.com/avatar/#{hash}"
end

def pref_gender
  ["Female", "Male"].sample
end

emails.each do |cur_email, gender|
  user = User.create(name: Faker::Name.name, email: cur_email, password: "123", location: Faker::Address.city, gender: gender, birthday: Faker::Date.between(50.years.ago, 18.years.ago), bio: Faker::Hacker.say_something_smart, preferred_gender: pref_gender )
  user.update_attributes(picture_url: find_gravatar_url(user))
  unless cur_email == "alex.taber0@gmail.com"
    Friendship.create(user_id: 1, friend_id: user.id, status: "approved")
  end
end

User.create(name: "Matchmaker", email: "matchmaker@mm.com", birthday: Faker::Date.between(50.years.ago, 18.years.ago), gender: "male", location: "NYC", password: "123", preferred_gender: pref_gender)