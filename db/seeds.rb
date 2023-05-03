names=["Horror", "Action", "Romantic", "Adventure", "Comedy"]
names.each {|name|
  Category.create!(name: name)
}

title = Faker::Movie.unique.title
  description = Faker::Movie.quote
  rating = 4.2
  duration_min = Faker::Number.between(from: 60, to: 300)
  release_time = Faker::Date.between(from: "2023-04-01", to: "2023-06-01")
  language = Faker::Nation.language
  director = Faker::Artist.unique.name
  cast = Faker::Artist.unique.name
  age_range = 18
  img_link = "https://cdn.galaxycine.vn/media/2022/8/29/1200-x-1800_1661753251433.jpg"
  Movie.create!(title: title,
                description: description,
                rating: rating,
                duration_min: duration_min,
                release_time: "2023-05-02",
                language: language,
                director: director,
                cast: cast,
                age_range: age_range,
                category_ids: [1],
                img_link: img_link,
                status: 1 )

20.times do
  title = Faker::Movie.unique.title
  description = Faker::Movie.quote
  rating = 4.2
  duration_min = Faker::Number.between(from: 60, to: 300)
  release_time = Faker::Date.between(from: "2023-04-01", to: "2023-05-01")
  language = Faker::Nation.language
  director = Faker::Artist.unique.name
  cast = Faker::Artist.unique.name
  age_range = 18
  img_link = "https://cdn.galaxycine.vn/media/2022/8/29/1200-x-1800_1661753251433.jpg"
  status = rand(0..1)
  Movie.create!(title: title,
                description: description,
                rating: rating,
                duration_min: duration_min,
                release_time: release_time,
                language: language,
                director: director,
                cast: cast,
                age_range: age_range,
                category_ids: [Category.all.pluck(:id).sample],
                img_link: img_link,
                status: status )
end
p "processing..."

start = 1234567890

5.times do |n|
  user_name = "User #{n}"
  email = "user#{n}@gmail.com"
  password = "password"
  User.create!(user_name: user_name,
    email: email,
    phone: start,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )

  start = start + 1
end

User.create!(user_name: "Admin",
  email: "admin@gmail.com",
  phone: "1234567819",
  password: "password",
  password_confirmation: "password",
  role: 1,
  activated: true,
  activated_at: Time.zone.now
)


cinemaNames = ["Winter Nguyễn Du", "Winter Thanh Xuân", "Winter Mễ Trì", "Winter Nguyễn Trãi ", "Winter Long Biên"]
cinemaNames.each {|cinemaName|
  location = cinemaName.delete "Winter "
  Cinema.create!(location: location, name: cinemaName)
}

cinemas = Cinema.all


cinemas.each do |cinema|
  index = 1
  5.times do
    name = "Winter #{index}"
    cinema.rooms.create!(row: 6, length: 10, name: name)
    index += 1
  end
end

time = Time.now
movies = Movie.all
rooms = Room.all
movies.each{ |movie|
  rooms.sample(10).each{ |room|
    start_time = time
    ShowTime.create!(
      start_time: start_time, movie_id: movie.id, room_id: room.id, price: Settings.price.standard
    )
  }
}

p "inserted successful"
