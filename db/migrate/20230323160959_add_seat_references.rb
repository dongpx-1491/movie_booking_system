class AddSeatReferences < ActiveRecord::Migration[7.0]
  def change
    add_reference(:show_times, :seat, foreign_key: true)
    add_reference(:seats, :tickets, foreign_key: true)
  end
end
