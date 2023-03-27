class MoviesController < ApplicationController
  before_action :find_movie, only: :show

  def new
    @movie = Movie.new
  end

  def show; end

  private
  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:danger] = t "film_not_found"
    redirect_to root_path
  end
end
