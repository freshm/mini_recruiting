# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = Admin.first

a = admin.advertisements.create(title: "Developer", description: "Develop something", location: "Munich", requirement: "Have a brain")
a.save

a = admin.advertisements.create(title: "Sleeper", description: "Sleep a lot ", location: "Anywhere, but here!", requirement: "Have a bed")
a.save

a = admin.advertisements.create(title: "Air Tester", description: "Breath air and rate it", location: "Anywhere", requirement: "Have a nose")
a.save

a = admin.advertisements.create(title: "Sheep immitating", description: "Act as a sheep", location: "Farm next door", requirement: "Have some animal noises")
a.save

a = admin.advertisements.create(title: "Couch tester", description: "Sit on couches and enjoy it", location: "Don't know", requirement: "Don't know")
a.save

a = admin.advertisements.create(title: "Döner tester", description: "Test Döner", location: "Germany", requirement: "Non vegetarian")
a.save

a = admin.advertisements.create(title: "Gamer", description: "Play various computer games", location: "In front of your PC", requirement: "Some mad skillz")
a.save

a = admin.advertisements.create(title: "Tree hugger", description: "Befriend some trees", location: "Forest", requirement: "Be a nightelf")
a.save