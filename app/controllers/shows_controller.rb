class ShowsController < ApplicationController
  before_action :find_movie
  before_action :logged_in_user, :store_show_time_url, only: :show

  def index
    @filter_showtime = ShowTime.ransack({filter_date: [params[:movie_id], params[:start_time] || Time.now]})
    @show_times = @filter_showtime.result.group_by(&:room_id)
    @cinemas = Cinema.all

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    unless check_payment? ||current_payment&.payment_expired? || current_payment&.active?
      delete_payment
      @payment = Payment.create user_id: current_user.id
      init_payment @payment
    end
    @show = ShowTime.find_by id: params[:id]
    @room = @show.room
  end

  private

  def find_movie
    @movie = Movie.find_by id: params[:movie_id]
    return if @movie

    flash[:warning] = t ".not_found"
    redirect_to root_path
  end
end
