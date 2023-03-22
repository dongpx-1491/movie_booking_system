class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.text :comment
      t.integer :favorite

      t.timestamps
    end
  end
end
