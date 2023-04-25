module MoviesHelper
  def showing? movie
    movie.release_time <= Time.zone.now
  end
end
