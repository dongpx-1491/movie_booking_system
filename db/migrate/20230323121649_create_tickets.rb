class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :price
      t.integer :type
      t.string :seat_number
      t.integer :status

      t.timestamps
    end
  end
end
