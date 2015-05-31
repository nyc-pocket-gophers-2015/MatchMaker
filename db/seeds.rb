emails = [ ["alex.taber0@gmail.com","male"],
["aris.a.perez@gmail.com", "male"],
["me@brendanmiranda.com", "male"],
["doralypantaleon@gmail.com", "female" ],
["echenique11@gmail.com", "male"],
["scottbwarner@gmail.com", "male"],
["sid.watal@gmail.com", "male"],
["ayme.alvarez@gmail.com", "male"],
["angiegrace84@gmail.com", "female"],
["nlee43@gmail.com", "male"],
["stauntonsample@gmail.com","male"],
["manentea@gmail.com", "male"],
["samantha.belkin@gmail.com", "female"],
["mmschneerson@gmail.com", "male"],
["marc.cardacci@gmail.com", "male"],
["lauris.bernhart@gmail.com", "male" ],
["julia.castro@outlook.com", "female"],
["sixthand6th@gmail.com", "male"],
["sheld0ri@gmail.com"], "male",
["gechrod@gmail.com", "male"],
["arthur.ross.wilson@gmail.com", "male"],
["bkmorimoto@gmail.com", "male"],
["deborah.a.milburn@gmail.com", "female"],
["ben.costolo@gmail.com", "male"],
["luciankahn@gmail.com", "male"],
["tara.c.frye@gmail.com", "female"],
["charles.green88@gmail.com"]]

def random_gender
  ["male", "female"][rand(0..1)]
end

def find_gravatar_url(user)
  hash = Digest::MD5.hexdigest(user.email)
  return "http://www.gravatar.com/avatar/#{hash}"
end

emails.each do |cur_email, gender|
  user = User.create(name: Faker::Name.name, email: cur_email, password: "123", location: Faker::Address.city, gender: gender, birthday: Faker::Date.between(50.years.ago, 18.years.ago), bio: Faker::Hacker.say_something_smart )
  user.update_attributes(picture_url: find_gravatar_url(user))
end