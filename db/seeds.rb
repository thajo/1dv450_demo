# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.create(name: 'Tottenham Hotspur FC', nickname: 'Spurs')
Team.create(name: 'Liverpool FC', nickname: 'The Reds')
Team.create(name: 'Everton FC', nickname: 'The Toffees')
Team.create(name: 'Manchester United', nickname: 'The red devils')

p = Player.create(name: 'Harry Kane', age: 23)
Team.find(1).players << p

p = Player.create(name: 'Danny Rose', age: 23)
Team.find(1).players << p

p = Player.create(name: 'Leighton Baines', age: 29)
Team.find(3).players << p


User.create(screenname: "John", email: "john.haggerud@lnu.se", password: "hemligt", password_confirmation: "hemligt")

100.times do |n|
  Team.create(name: "Team nr #{n}", nickname: "Team#{n}")
end



