class RemoveColumnTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :ticket_type
    remove_column :tickets, :seat_number
    remove_column :tickets, :status
  end
end
