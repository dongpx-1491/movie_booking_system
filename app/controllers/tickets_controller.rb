class TicketsController < ApplicationController
  before_action :logged_in_user
  before_action :load_ticket, only: :destroy

  def show; end

  def create
    @ticket = Ticket.new payment_id: current_payment.id, show_time_id: params[:show_time_id], seat_position: params[:seat_position]
    return respond_to :js if @ticket.save && total_price

    flash[:danger] = t ".unavailable_ticket"
    render js: "window.location = '#{session[:show_time_url]}'"
  end

  def destroy
    @index = params[:index]
    @show_id = @ticket.show_time.id
    @seat_position = @ticket.seat_position

    respond_to :js if @ticket.destroy && total_price
  end

  private

  def load_ticket
    @ticket = Ticket.find_by(payment_id: current_payment.id, show_time_id: params[:show_time_id], seat_position: params[:seat_position])
    return if @ticket

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
