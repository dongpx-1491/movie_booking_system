require "rake"
namespace :db do
  desc "task description"
  task create_booking: :environment do
    p "start create bookings"

    10.times do
      user = User.all.sample
      payment = user.payments.create
      10.times do
        seat_number = rand(1..10)
        row = ('A'..'B').to_a.shuffle
        ticket = Ticket.new(
          payment_id: payment.id,
          show_time_id: ShowTime.all.sample.id,
          seat_position: "#{row[seat_number]}#{seat_number}"
        )
        ticket.save
      end
      payment.activate_payment
      payment.update_attribute :activated_at, DateTime.now.next_day + 2.days
    end
  end
end
