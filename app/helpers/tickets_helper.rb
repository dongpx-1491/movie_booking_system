module TicketsHelper
  def is_booking? show_time_id, seat_position
    Ticket.find_by(payment_id: current_payment.id, show_time_id: show_time_id, seat_position: seat_position)&.payment&.inactive?
  end

  def was_taken? show_time_id, seat_position
    Ticket.find_by(show_time_id: show_time_id, seat_position: seat_position)
  end

  def payment_seat_position show_time_id
    Ticket.where(payment_id: current_payment.id, show_time_id: show_time_id).pluck(:seat_position).join(', ')
  end
end
