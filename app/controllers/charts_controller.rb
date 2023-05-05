class ChartsController < ApplicationController
  def top_movies_seller
    movie_tickets = {}
    Movie.all.each{|m| movie_tickets[m.title] = m.revenue}
    @top_movies_seller = movie_tickets.sort_by { |k, v| v }.reverse.take 5
    render json: @top_movies_seller
  end

  def top_movies_booking
    movie_tickets = {}
    Movie.all.each{|m| movie_tickets[m.title] = m.tickets.size}
    @top_movies_seller = movie_tickets.sort_by { |k, v| v }.reverse.take 5
    render json: @top_movies_seller
  end
end
