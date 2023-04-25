class RatesController < ApplicationController
  before_action :find_movie

  def create
    @rate = current_user.rates.build(movie_id: params[:movie_id],
                                         comment: params[:rate][:comment])
    @status = @rate.save
    @pagy, @rates = pagy @movie.rates.latest, items: 5

    respond_to do |format|
      format.html{redirect_to movie_path(@movie)}
      format.js
    end
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:movie_id]
    return if @movie

    flash[:warning] = t "not_found"
    redirect_to root_path
  end
end
