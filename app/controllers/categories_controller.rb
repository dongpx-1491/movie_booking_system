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
    @pagy, @movies = pagy @category.movies.sort_list, items: 9
  end
end
