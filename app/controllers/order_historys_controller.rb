class OrderHistorysController < ApplicationController
  def index
    @payments = current_user.payments
    if @payments.present?
      @search_order = current_user.payments.ransack(params[:q])
      @search_order.sorts = "activated_at DESC" if @search_order.sorts.empty?
      @pagy, @payments = pagy @search_order.result.show_active.latest, items: 10
    else
      flash[:info] = t ".info"
      redirect_to root_url
    end
  end

  def show
    @payment = Payment.find_by id: params[:id]
    if @payment.present?
      @tickets = @payment.tickets
    else
      flash[:danger] = t ".danger"
      redirect_to order_historys_path
    end
  end
end
