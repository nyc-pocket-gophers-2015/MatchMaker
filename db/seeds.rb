# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
emails = ["alex.taber0@gmail.com",
"aris.a.perez@gmail.com",
"me@brendanmiranda.com",
"doralypantaleon@gmail.com",
"echenique11@gmail.com",
"scottbwarner@gmail.com",
"sid.watal@gmail.com",
"ayme.alvarez@gmail.com",
"angiegrace84@gmail.com",
"nlee43@gmail.com",
"stauntonsample@gmail.com",
"manentea@gmail.com",
"samantha.belkin@gmail.com",
"mmschneerson@gmail.com",
"marc.cardacci@gmail.com",
"lauris.bernhart@gmail.com",
"julia.castro@outlook.com",
"sixthand6th@gmail.com",
"sheld0ri@gmail.com",
"gechrod@gmail.com",
"arthur.ross.wilson@gmail.com",
"bkmorimoto@gmail.com",
"deborah.a.milburn@gmail.com",
"ben.costolo@gmail.com",
"luciankahn@gmail.com",
"tara.c.frye@gmail.com",
"charles.green88@gmail.com"]

def random_gender
  ["male", "female"][rand(0..1)]
end

def find_gravatar_url(user)
  hash = Digest::MD5.hexdigest(user.email)
  return "http://www.gravatar.com/avatar/#{hash}"
end

emails.each do |cur_email|
  user = User.create(name: Faker::Name.name, email: cur_email, password: "123", location: Faker::Address.city, gender: random_gender, birthday: Faker::Date.between(100.years.ago, 18.years.ago), bio: Faker::Hacker.say_something_smart )
  user.update_attributes(picture_url: find_gravatar_url(user))
end