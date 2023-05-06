class Admin::StaticPagesController < AdminController
  def home
    @top_movies_revenue = Movie.all.top_seller.limit 10
    @number_movies = Movie.by_month(DateTime.now.month).size
    @number_movies_before = Movie.by_month(DateTime.now.prev_month.month).size
    @number_shows = ShowTime.by_month(DateTime.now.month).size
    @number_shows_before = ShowTime.by_month(DateTime.now.prev_month.month).size
    @number_tickets = Ticket.by_month(DateTime.now.month).size
    @number_tickets_before = Ticket.by_month(DateTime.now.prev_month.month).size
    @number_revenue = Payment.show_active.by_month(DateTime.now.month).pluck(:total_cost).sum
    @number_revenue_before = Payment.show_active.by_month(DateTime.now.prev_month.month).pluck(:total_cost).sum
  end
end
