class Admin::MoviesController < AdminController
  before_action :find_movie, only: %i(edit update destroy)

  def index
    @search = Movie.all.ransack(params[:q])
    @pagy, @movies = pagy @search.result,
                          items: Settings.model.limited
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    if @movie.save
      flash[:success] = t "movie_create"
      redirect_to admin_movies_path
    else
      flash[:danger] = t "movie_create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if params.dig(:movie, :status_before_type_cast)
      update_active
    else
      update_all
    end
  end

  def destroy
    if @movie.shows.any?
      flash[:danger] = t "movie_delete_denied"
    elsif @movie.destroy
      flash[:success] = t "movie_delete"
    else
      flash[:danger] = t "movie_delete_failed"
    end
    redirect_to admin_movies_path
  end

  private
  def movie_params
    params.require(:movie).permit(Movie::MOVIE_ATTRS, :image, :banner, category_ids: [],
      movie_categories_attributes:
          [:id, :movie_id, :category_id])
  end

  def update_active
    if params.dig(:movie, :status_before_type_cast) == "0"
      if @movie.show_times.not_out_of_date.size == 0
        if @movie.update_column(:status,
                                params.dig(:movie, :status_before_type_cast))
          flash[:success] = t("movie_update")
        else
          flash[:danger] = t("movie_update_failed")
        end
      else
        flash[:danger] = t("movie_update_denied")
      end
    else
      if @movie.update_column(:status, params.dig(:movie, :status_before_type_cast))
        flash[:success] = t("movie_update")
      else
        flash[:danger] = t("movie_update_failed")
      end
    end
    redirect_to admin_movies_path
  end

  def update_all
    if @movie.update movie_params
      flash[:success] = t(".movie_update")
      redirect_to admin_movies_path
    else
      flash[:danger] = t("movie_update_failed")
      render :edit
    end
  end

  def find_movie
    @movie = Movie.find_by id: params[:id]
    return if @movie

    flash[:danger] = t "not_found"
    redirect_to admin_root_path
  end
end
