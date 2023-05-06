class ChartsController < ApplicationController
  def top_movies_seller
    movie_tickets = {}
    Movie.all.each{|m| movie_tickets[m.title] = m.revenue}
    @top_movies_seller = movie_tickets.sort_by { |k, v| v }.reverse.take 10
    render json: @top_movies_seller
  end

  def top_movies_booking
    movie_tickets = {}
    Movie.all.each{|m| movie_tickets[m.title] = m.tickets.size}
    @top_movies_seller = movie_tickets.sort_by { |k, v| v }.reverse.take 5
    render json: @top_movies_seller
  end

  def revenue_by_day
    revenue = {}
    group = Payment.all.group_by { |p| p.activated_at.to_date }
    group.each{|k, v|revenue[k] = v.sum {|p| p.total_cost}}
    @revenue_data = revenue
    render json: @revenue_data
  end
end
