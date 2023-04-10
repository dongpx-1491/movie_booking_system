class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.decimal :total_cost, precision: 10, scale: 2, default: "0.0", null: false
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
