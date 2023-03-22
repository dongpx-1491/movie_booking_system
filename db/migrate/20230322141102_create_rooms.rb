class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.integer :row
      t.integer :length

      t.timestamps
    end
  end
end
