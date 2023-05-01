class Admin::CategoriesController < AdminController
  before_action :find_category, only: %i(edit update destroy)

  def index
    @pagy, @categories = pagy Category.asc_name
  end

  def new
    @category = Category.new
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "genre_updated"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "genre_update_failed"
      render :edit
    end
  end

  def destroy
    if @category.movies.any?
      flash[:danger] = t "delete_denied"
    elsif @category.destroy
      flash[:success] = t "genre_delete"
    else
      flash[:danger] = t "genre_delete_failed"
    end
    redirect_to admin_categories_path
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "genre_create"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "genre_create_failed"
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
