class SpecificMoviesController < ApplicationController
  def showing_movie
    @search = Movie.is_release.ransack(params[:q])
    @search.sorts = "release_time DESC" if @search.sorts.empty?
    @pagy, @movies = pagy @search.result, items: 8
  end

  def comming_movie
    @search = Movie.not_release.ransack(params[:q])
    @search.sorts = "release_time DESC" if @search.sorts.empty?
    @pagy, @movies = pagy @search.result, items: 8
  end
end
