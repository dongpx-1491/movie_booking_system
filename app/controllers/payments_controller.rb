class PaymentsController < ApplicationController
  before_action :load_payment, :check_expiration

  def show
    @tickets = @payment.tickets
    render :non_payment if @tickets.blank?
  end

  def activation
    @payment.create_activation_digest
    @payment.send_activation_email

    flash[:info] = t ".info"
    redirect_to root_path
  end

  def destroy
    delete_payment if have_payment?
    if @payment.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end

    render :non_payment
  end

  private

  def load_payment
    @payment = current_payment
    return if @payment

    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def check_expiration
    return unless @payment.payment_expired?

    delete_payment
    flash[:danger] = t ".danger"
    redirect_to root_path
  end
end
