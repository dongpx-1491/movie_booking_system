require "rake"
namespace :db do
  desc "task description"
  task create_shows: :environment do
    p "start create shows"
    time = Time.now + 1.days
    movies = Movie.all
    rooms = Room.all
    movies.each do |movie|
      rooms.sample(10).each do |room|
        start_time = time
        end_time = start_time + 2*60*60
        ShowTime.create!(start_time: start_time, end_time: end_time, movie_id: movie.id, room_id: room.id)
        time = end_time
      end
    end
  end
end
