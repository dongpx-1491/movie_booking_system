class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :status
      t.decimal :total_cost

      t.timestamps
    end
  end
end
