module Admin::MoviesHelper
  def movie_ticket_revenue movie
    total = 0
    movie.tickets.each{|ticket| total += ticket.show_time_price}
    total
  end
end
