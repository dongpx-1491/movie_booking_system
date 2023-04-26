module MoviesHelper
  def showing? movie
    movie.release_time <= Time.zone.now
  end

  def sort_value
    if @search && @search.sorts.present?
      [@search.sorts.first.name, @search.sorts.first.dir].join(' ')
    end
  end
end
