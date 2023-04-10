names=["Horror", "Action", "Romantic", "Adventure", "Comedy"]
names.each {|name|
  Category.create!(name: name)
}

20.times do
  title = Faker::Movies::Lebowski.actor
  description = Faker::Movie.quote
  rating = 4.2
  duration_min = 120
  release_time = "9/9/2022"
  language = "English"
  director = "Faker"
  cast = Faker::Movies::Lebowski.actor
  age_range = 18
  category_id = 2
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
                category_id: Category.all.pluck(:id).sample,
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
  )

  start = start + 1
end

User.create!(user_name: "Admin",
  email: "admin@gmail.com",
  phone: "1234567819",
  password: "password",
  password_confirmation: "password",
  role: 1
)


cinemaNames = ["Galaxy Nguyễn Du", "Galaxy Tân Bình", "Galaxy Kinh Dương", "Galazy Quang Trung", "Galaxy Long Bien"]
cinemaNames.each {|cinemaName|
  Cinema.create!(location: "Cầu Giấy", name: cinemaName)
}
cinemas = Cinema.all
10.times do
  cinemas.each { |cinema| cinema.rooms.create!(row: 20, length: 30) }
end

time = Time.now
movies = Movie.all
rooms = Room.all
movies.each{ |movie|
  rooms.sample(10).each{ |room|
    start_time = time
    end_time = start_time + 2*60*60
    ShowTime.create!(
      start_time: start_time, end_time: end_time, movie_id: movie.id, room_id: room.id
    )
    time = end_time
  }
}

p "inserted successful"
