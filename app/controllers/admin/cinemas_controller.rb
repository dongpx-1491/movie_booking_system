class Admin::CinemasController <   AdminController
  before_action :find_cinema, only: %i(edit update destroy)

  def index
    @pagy, @cinemas = pagy Cinema.asc_name
  end

  def new
    @cinema = Cinema.new
  end

  def edit; end

  def update
    if @cinema.update cinema_params
      flash[:success] = t ".updated"
      redirect_to admin_cinemas_path
    else
      flash[:danger] = t ".update_failed"
      render :edit
    end
  rescue StandardError, LoadError => e
    flash[:danger] = t ".restric"
    render :edit
  end

  def destroy
    if @cinema.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to admin_cinemas_path
  rescue StandardError, LoadError => e
    flash[:danger] = t ".restric"
    redirect_to admin_cinemas_path
  end

  def create
    @cinema = Cinema.new cinema_params
    if @cinema.save
      flash[:success] = t ".created"
      redirect_to admin_cinemas_path
    else
      flash[:danger] = t "create_failed"
      render :new
    end
  end

  private

  def cinema_params
    params.require(:cinema).permit(:name, :location, rooms_attributes: [:id, :name, :row, :length, :_destroy])
  end

  def find_cinema
    @cinema = Cinema.find_by id: params[:id]
    return if @cinema

    flash[:danger] = t ".not_found_cinema"
    redirect_to admin_cinemas_path
  end
end
