class CreateRate < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.text :comment
      t.timestamps
    end
  end
end
