# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



User.create(
  :name => "Stephanie",
  :email => "stephanie@stephanie.com",
  :password => "stephanie"
)

User.create(
  :name => "Joshua",
  :email => "joshua@joshua.com",
  :password => "joshuajoshua"
)

User.create(
  :name => "Charlotte",
  :email => "Charlotte@Charlotte.com",
  :password => "charlotte"
)

User.create(
  :name => "Shelly",
  :email => "shelly@shelly.com",
  :password => "shellyshelly"
)

UserHunt.create(
  :user_id => 1,
  :hunt_id => 1,
)
UserHunt.create(
  :user_id => 2,
  :hunt_id => 1,
)
UserHunt.create(
  :user_id => 3,
  :hunt_id => 1,
)
UserHunt.create(
  :user_id => 4,
  :hunt_id => 1,
)

Hunt.create(
  :title => "August Hunt",
)

15.times do
  Apartment.create(
    :hunt_id => 1,
    :address => Faker::Address.street_address,
    :link => Faker::Internet.url,
    :contact => Faker::Internet.email,
    :price => 4000
  )
end
