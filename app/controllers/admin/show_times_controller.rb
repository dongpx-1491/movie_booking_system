class Admin::ShowTimesController < AdminController
  before_action :find_show, only: %i(edit update destroy)

  def index
    @pagy, @shows = pagy ShowTime.incre_order, items: 10
  end

  def new
    @show = ShowTime.new
  end

  def create
    @show = ShowTime.new show_params
    if @show.save
      flash[:success] = t ".show_create"
      redirect_to admin_show_times_path
    else
      flash[:danger] = t ".show_create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @show.tickets.any?
      flash[:danger] = t "ticket_present"
      render :edit
    elsif @show.update show_params
      flash[:success] = t ".show_update"
      redirect_to admin_show_times_path
    else
      flash[:danger] = t ".show_update_failed"
      render :edit
    end
  end

  def destroy
    if @show.tickets.any?
      flash[:danger] = t "ticket_present"
      return redirect_to admin_show_times_path
    elsif @show.destroy
      flash[:success] = t ".show_delete"
    else
      flash[:danger] = t ".show_delete_failed"
    end
    redirect_to admin_show_times_path
  end

  private
  def show_params
    params.require(:show_time).permit ShowTime::SHOW_ATTR
  end

  def find_show
    @show = ShowTime.find_by id: params[:id]
    return if @show

    flash[:danger] = t "not_found"
    redirect_to root_path
  end
end
