module MoviesHelper
  def showing? movie
    movie.release_time <= Time.zone.now
  end

  def sort_value
    if @search && @search.sorts.present?
      [@search.sorts.first.name, @search.sorts.first.dir].join(' ')
    end
  end

  def movie_revenue movie
    total = 0
    movie.tickets.each{|ticket| total += ticket.show_time_price}
    total
  end
end
