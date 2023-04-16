module PaymentsHelper
  def init_payment payment
    session[:payment_id] = payment.id
  end

  def current_payment
    @current_payment ||= Payment.find_by id: session[:payment_id]
  end

  def have_payment?
    current_payment.present?
  end

  def delete_payment
    session.delete :payment_id
    @current_payment = nil
  end

  def sum_price_show show_time_id
    Ticket.where(payment_id: current_payment.id, show_time_id: show_time_id).size * 50000
  end

  def total_price ticket
    total = current_payment.tickets.size * 50000
    current_payment.update_attribute(:total, total)
  end
end
