require "rake"
namespace :db do
  desc "task description"
  task create_shows: :environment do
    p "start create shows"
    movies = Movie.all
    rooms = Room.all

    rooms.sample(10).each{ |room|
      @start_time = Time.now + 1.hours
      movies.each{ |movie|
        st = ShowTime.create!(
          start_time: @start_time, movie_id: movie.id, room_id: room.id, price: Settings.price.standard
        )
        @start_time = st.end_time + 10.minutes
      }
    }
  end
end
