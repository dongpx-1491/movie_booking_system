class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.integer :phone
      t.datetime :dob

      t.timestamps
    end
  end
end
