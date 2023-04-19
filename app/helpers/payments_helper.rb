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

  def check_payment?
    Payment.find_by(id: session[:payment_id]) && session[:payment_id]
  end

  def delete_payment
    current_payment.destroy if current_payment&.inactive?
    session.delete :payment_id
    @current_payment = nil
  end

  def sum_price_show show_time_id
    show_tickets = Ticket.where(payment_id: current_payment.id, show_time_id: show_time_id)
    return 0 if show_tickets.blank?

    show_tickets.size * show_tickets.first.show_time_price
  end

  def total_price
    total = current_payment.tickets.inject(0){|sum, ticket| sum + ticket.show_time_price}
    current_payment.update_attribute(:total_cost, total)
  end
end
