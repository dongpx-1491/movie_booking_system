class CreateShowTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :show_times do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer  :price
      t.timestamps
    end
  end
end
