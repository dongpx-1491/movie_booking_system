class MoviesController < ApplicationController
  before_action :find_movie, only: :show
  before_action :related_movie

  def show
    @pagy, @rates = pagy @movie.rates.latest,
                           items: Settings.page.comment
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end

  def related_movie
    @categories_ids = @movie.categories&.pluck :id
    @related_movie = Movie.joins(:categories).where('categories.id IN (?)', @categories_ids).limit(5)
  end
end
