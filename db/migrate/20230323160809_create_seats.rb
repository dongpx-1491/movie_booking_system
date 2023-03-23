class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.string :seat_number
      t.integer :status
      t.integer :seat_type

      t.timestamps
    end
  end
end
