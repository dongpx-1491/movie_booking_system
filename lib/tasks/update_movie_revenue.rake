require "rake"
namespace :update_namespace do
  desc "update movie revenue"
  task update_movie_revenue: :environment do
    Movie.all.each do |movie|
      movie.update_revenue
    end
  end
end
