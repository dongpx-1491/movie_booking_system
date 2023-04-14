class AddReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference(:payments, :user, foreign_key: true)
    add_reference(:rates, :user, foreign_key: true)
    add_reference(:rates, :movie, foreign_key: true)
    add_reference(:show_times, :movie, foreign_key: true)
    add_reference(:tickets, :show_time, foreign_key: true)
    add_reference(:tickets, :payment, foreign_key: true)
    add_reference(:show_times, :room, foreign_key: true)
    add_reference(:rooms, :cinema, foreign_key: true)
  end
end
