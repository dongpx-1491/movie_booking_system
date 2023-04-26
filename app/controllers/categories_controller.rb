class CategoriesController < ApplicationController
  before_action :find_genre, :load_movie, only: :show
  before_action :hot_movie
  def show;
  end

  private

  def find_genre
    @category = Category.find_by id: params[:id]

    return if @category

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end

  def load_movie
    @search = @category.movies.ransack(params[:q])
    @search.sorts = "release_time DESC" if @search.sorts.empty?
    @pagy, @movies = pagy @search.result, items: 9
  end
end
