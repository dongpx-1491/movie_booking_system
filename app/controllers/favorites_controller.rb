class FavoritesController < ApplicationController
  before_action :logged_in_user

  def index
    @search = current_user&.movies.ransack(params[:q])
    @search.sorts = "release_time DESC" if @search.sorts.empty?
    @pagy, @movies = pagy @search.result, items: 8
  end

  def create
    current_user.favorites.create movie_id: params[:id]
    respond_to :js
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])
    if @favorite
      @favorite.destroy
      respond_to :js
    else
      redirect_to movie_path(params[:id])
    end
  end
end
