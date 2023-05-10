require "rake"
namespace :db do
  desc "task description"
  task create_shows: :environment do
    p "start create shows"
    movies = Movie.where id: [3, 9, 11]

    movies.each{ |movie|
      @start_time = Time.now + 1.days
      20.times do
        st = ShowTime.new(
          start_time: @start_time, movie_id: movie.id, room_id: 1, price: Settings.price.standard
        )
        st.save
        @start_time = st.end_time + 1.hours if st.valid?
      end
    }
  end
end
