class AdGroupIndexToTickets < ActiveRecord::Migration[7.0]
  def change
    add_index :tickets, [:show_time_id, :seat_position], unique: true
  end
end
