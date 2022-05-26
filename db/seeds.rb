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
Spatioport.destroy_all

puts 'We want the shuttles ...'

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558920/x8gy8nt3ftripz2ldxgt.jpg')

shuttle = Shuttle.create!(
  model: "TIE Silencer",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'tie_silencer.jpg', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558903/dto4fahordwzd0cn8sas.jpg')

Shuttle.create!(
  model: "Rey's Speeder",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'rey_speeder.jpg', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558862/haghtovlywkupvapevvr.jpg')

Shuttle.create!(
  model: "Naboo N-1 Starfighter",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'naboo_starfighter.jpg', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558735/kz9a6qrrk80fkojshlta.jpg')

Shuttle.create!(
  model: "Imperial Shuttle",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'imperial_shuttle.jpg', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558628/qrfonfy8h56f3ohca9ru.jpg')

Shuttle.create!(
  model: "Imperial Star Destroyer",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'imperial_star_destroyer.jpg', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558817/x8hxkiyrqdssd0jaimbt.jpg')

Shuttle.create!(
  model: "Millenium Falcon",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'millenium_falcon.jpg', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558686/ts0wg3paj1dvnefoc2vi.jpg')

Shuttle.create!(
  model: "Ghost",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'ghost.jpg', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558657/rzoelnorl9hzdmda54e1.jpg')

Shuttle.create!(
  model: "First Order TIE Fighter",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'first_order_tie_fighter', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558735/kz9a6qrrk80fkojshlta.jpg')

Shuttle.create!(
  model: "Imperial Shuttle",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'imperial_shuttle.jpg', content_type: 'image/jpg')

file = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653558891/k31qu7wem4psa5szv8ml.jpg')

Shuttle.create!(
  model: "Phantom II",
  max_capacity: (2...10).to_a.sample
)

shuttle.photo.attach(io: file, filename: 'phantom_2.jpg', content_type: 'image/jpg')

puts 'We have now ten of them'

puts 'Let create 10 spatioports'

10.times do
  city = Faker::Address.city
  Spatioport.create!(
    name: "Spatioport of #{city} city",
    address: city
  )
end

puts 'Done!'

puts 'AAAAAAAAAND this is our user with its trips and bookings'

avatar = URI.open('https://res.cloudinary.com/dx5ha1ecm/image/upload/v1653568759/ajwiov5xeub3z1susfsh.jpg')

main_user = User.create!(
  email: 'hello@milkyrails.com',
  password: 'password',
  first_name: "Jean-Michel",
  last_name: "Jean-Jean"
)

main_user.photo.attach(io: avatar, filename: 'avatar.jpg', content_type: 'image/jpg')

3.times do
  planet_pic = URI.open('https://source.unsplash.com/random/?planet')

  trip = Trip.create!(
    destination: Faker::Movies::StarWars.planet,
    description: Faker::Lorem.paragraph(sentence_count: 10),
    price_per_day: [10_000, 15_000, 20_000, 30_000, 40_000, 50_000, 100_000].sample,
    min_duration: (3...10).to_a.sample,
    spatioport_id: Spatioport.all.sample.id,
    shuttle_id: Shuttle.all.sample.id,
    user_id: main_user.id
  )

  trip.photo.attach(io: planet_pic, filename: 'planet.jpg', content_type: 'image/jpg')
end

3.times do
  trip = Trip.all.sample

  Booking.create!(
    start_date: Faker::Date.in_date_period(year: 2152),
    end_date: Faker::Date.in_date_period(year: 2152) + 10,
    confirmed: [true, false].sample,
    user_id: main_user.id,
    trip_id: trip.id,
    number_of_people: trip.shuttle.max_capacity - 1
  )
end

puts 'You are born, lucky you ...'

puts 'Creating five spaceships owners with each 5 trips'

5.times do
  profile_pic = URI.open('https://source.unsplash.com/random/?avatar')
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  user.photo.attach(io: profile_pic, filename: 'avatar.jpg', content_type: 'image/jpg')

  5.times do
    planet_pic = URI.open('https://source.unsplash.com/random/?planet')

    trip = Trip.create!(
      destination: Faker::Movies::StarWars.planet,
      description: Faker::Lorem.paragraph(sentence_count: 10),
      price_per_day: [10_000, 15_000, 20_000, 30_000, 40_000, 50_000, 100_000].sample,
      min_duration: (3...10).to_a.sample,
      spatioport_id: Spatioport.all.sample.id,
      shuttle_id: Shuttle.all.sample.id,
      user_id: user.id
    )

    trip.photo.attach(io: planet_pic, filename: 'planet.jpg', content_type: 'image/jpg')
  end
end

puts 'We have our owners AND our trips!'

puts "Creating 'classic' users and their bookings"

10.times do
  profile_pic = URI.open('https://source.unsplash.com/random/?avatar')
  user = User.create!(
    email: Faker::Internet.email,
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
  user.photo.attach(io: profile_pic, filename: 'avatar.jpg', content_type: 'image/jpg')

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
