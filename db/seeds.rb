# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts "To start, let's destroy the db"

Booking.destroy_all
Trip.destroy_all
User.destroy_all
Shuttle.destroy_all

puts 'We want the shuttles ...'

20.times do
  Shuttle.create!(
    model: Faker::Movies::StarWars.vehicle,
    max_capacity: (2...10).to_a.sample
  )
end

puts 'We have now twenty of them'

puts 'Creating five spaceships owners with each 5 trips'

5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

  5.times do
    Trip.create!(
      destination: Faker::Movies::StarWars.planet,
      price_per_day: [10_000, 15_000, 20_000, 30_000, 40_000, 50_000, 100_000].sample,
      min_duration: (3...10).to_a.sample,
      shuttle_id: Shuttle.all.sample.id,
      user_id: user.id
    )
  end


end

puts 'We have our owners AND our trips!'

puts "Creating 'classic' users and their bookings"

10.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

  trip = Trip.all.sample

  Booking.create!(
    start_date: Faker::Date.in_date_period(year: 2152),
    end_date: Faker::Date.in_date_period(year: 2152) + 10,
    confirmed: [true, false].sample,
    user_id: user.id,
    trip_id: trip.id,
    number_of_people: trip.shuttle.max_capacity - 1
  )

end

puts 'We have our customers!'
