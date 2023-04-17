class AddNewColumnToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :activation_digest, :string
    add_column :payments, :activated_at, :datetime
  end
end
